// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get toggleSidebar => 'Toggle sidebar';

  @override
  String get businessManagement => 'Business Management';

  @override
  String get verificationQueue => 'Verification Queue';

  @override
  String get noPendingVerifications => 'No pending verification requests.';

  @override
  String get cnicLabel => 'CNIC';

  @override
  String get documentsLabel => 'Documents';

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get approveBusinessTitle => 'Approve business?';

  @override
  String approveBusinessMessage(String business) {
    return 'Approve $business for verification?';
  }

  @override
  String get rejectBusinessTitle => 'Reject business?';

  @override
  String get rejectionReason => 'Rejection reason';

  @override
  String get verificationActionSuccess =>
      'Verification request processed successfully.';

  @override
  String get verificationActionFailed =>
      'Unable to process verification request. Please try again.';

  @override
  String get investorManagement => 'Investor Management';

  @override
  String get reportsAndComplaints => 'Reports & Complaints';

  @override
  String get systemAuditLogs => 'System / Audit Logs';

  @override
  String get adminSettings => 'Admin Settings';

  @override
  String get profile => 'Profile';

  @override
  String get profileSettings => 'Profile & Settings';

  @override
  String get notificationsPlaceholder => 'Notifications';

  @override
  String get logoutConfirmationTitle => 'Sign out?';

  @override
  String get logoutConfirmationMessage =>
      'You will be returned to the admin login screen.';

  @override
  String get cancel => 'Cancel';

  @override
  String get totalBusinesses => 'Total Businesses';

  @override
  String get pendingVerifications => 'Pending Verifications';

  @override
  String get activeInvestors => 'Active Investors';

  @override
  String get totalInvestmentRequests => 'Total Investment Requests';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get recentActivityPlaceholder =>
      'Recent platform activity will appear here in a later phase.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get reviewPendingBusiness => 'Review Pending Business';

  @override
  String get viewReports => 'View Reports';

  @override
  String get mockDashboardDataNotice =>
      'Static layout preview — no live data is connected.';

  @override
  String get verificationOfficer => 'Verification Officer';

  @override
  String get supportModerator => 'Support / Moderator';

  @override
  String get analyst => 'Analyst';

  @override
  String get appName => 'Seen Profits Admin';

  @override
  String get adminPortal => 'Administration portal';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get businesses => 'Businesses';

  @override
  String get verification => 'Verification';

  @override
  String get investors => 'Investors';

  @override
  String get businessOwners => 'Business Owners';

  @override
  String get investmentRequests => 'Investment Requests';

  @override
  String get reports => 'Reports';

  @override
  String get categories => 'Categories';

  @override
  String get notifications => 'Notifications';

  @override
  String get content => 'Content';

  @override
  String get analytics => 'Analytics';

  @override
  String get auditLogs => 'Audit Logs';

  @override
  String get adminAccounts => 'Admin Accounts';

  @override
  String get settings => 'Settings';

  @override
  String get login => 'Login';

  @override
  String get twoFactorAuthentication => 'Two-factor authentication';

  @override
  String get loginPlaceholderTitle => 'Admin login';

  @override
  String get loginPlaceholderDescription =>
      'Authentication will be connected in a later phase.';

  @override
  String get twoFactorPlaceholderTitle => 'Two-factor authentication';

  @override
  String get twoFactorPlaceholderDescription =>
      'Two-factor verification will be connected in a later phase.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get comingSoon => 'Coming in the next phase';

  @override
  String get comingSoonDescription =>
      'This section is ready for its feature implementation.';

  @override
  String get dashboardPlaceholderTitle => 'Dashboard foundation ready';

  @override
  String get dashboardPlaceholderDescription =>
      'The admin shell and routing are ready. Dashboard data will be added in a later phase.';

  @override
  String get menu => 'Menu';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get urdu => 'Urdu';

  @override
  String get administrator => 'Administrator';

  @override
  String get superAdmin => 'Super Admin';

  @override
  String get signOut => 'Sign out';

  @override
  String get openNavigation => 'Open navigation';

  @override
  String get closeNavigation => 'Close navigation';

  @override
  String get adminLoginTitle => 'Admin Login';

  @override
  String get adminLoginDescription =>
      'Sign in to access the Seen Profits administration portal.';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get requiredField => 'This field is required.';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get invalidCredentials =>
      'The email or password is not valid for this mock environment.';

  @override
  String get invalidVerificationCode =>
      'Enter the valid 6-digit verification code.';

  @override
  String get enterVerificationCodeDescription =>
      'Enter the 6-digit verification code to continue.';

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend code';

  @override
  String resendCodeIn(int seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get backToLogin => 'Back to login';

  @override
  String get submit => 'Submit';

  @override
  String get forgotPasswordDescription =>
      'Enter your email address and we will simulate a password-reset request.';

  @override
  String get passwordResetMockSuccess =>
      'Mock reset request sent. No email is delivered in this development-only flow.';

  @override
  String get mockLoginHint =>
      'Development mock: use admin@demo.local and DemoAdmin123!';

  @override
  String get mockTwoFactorHint => 'Development mock code: 123456';

  @override
  String get mockCodeResent =>
      'Mock verification code resent. Use the development code shown below.';

  @override
  String get signingIn => 'Signing in';

  @override
  String get verifyingCode => 'Verifying code';

  @override
  String get sendingResetRequest => 'Sending reset request';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String get searchBusinesses => 'Search businesses';

  @override
  String get businessStatus => 'Status';

  @override
  String get allStatuses => 'All statuses';

  @override
  String get active => 'Active';

  @override
  String get suspended => 'Suspended';

  @override
  String get pending => 'Pending';

  @override
  String get businessName => 'Business name';

  @override
  String get owner => 'Owner';

  @override
  String get category => 'Category';

  @override
  String get actions => 'Actions';

  @override
  String get viewBusiness => 'View business';

  @override
  String get editBusiness => 'Edit business';

  @override
  String get noBusinessesFound => 'No businesses match your filters.';

  @override
  String businessActionSelected(String action, String business) {
    return '$action selected for $business';
  }

  @override
  String get businessRecordAlpha => 'Alpha Foods';

  @override
  String get businessRecordVertex => 'Vertex Solutions';

  @override
  String get businessRecordGreenfield => 'Greenfield Farms';

  @override
  String get businessRecordAtlas => 'Atlas Textiles';

  @override
  String get businessOwnerAyesha => 'Ayesha Khan';

  @override
  String get businessOwnerBilal => 'Bilal Ahmed';

  @override
  String get businessOwnerFatima => 'Fatima Noor';

  @override
  String get businessOwnerHamza => 'Hamza Ali';

  @override
  String get foodAndBeverage => 'Food & Beverage';

  @override
  String get technology => 'Technology';

  @override
  String get agriculture => 'Agriculture';

  @override
  String get manufacturing => 'Manufacturing';

  @override
  String get businessDetails => 'Business details';

  @override
  String get close => 'Close';

  @override
  String get assignedPlan => 'Assigned tier / plan';

  @override
  String get starterPlan => 'Starter';

  @override
  String get growthPlan => 'Growth';

  @override
  String get enterprisePlan => 'Enterprise';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get businessUpdated => 'Business details updated.';

  @override
  String get businessUpdateFailed =>
      'Unable to update business details. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get activeBusinesses => 'Active Businesses';

  @override
  String get pendingBusinesses => 'Pending Businesses';

  @override
  String get suspendedBusinesses => 'Suspended Businesses';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get monthlyGrowth => 'Monthly Growth';

  @override
  String get refreshDashboard => 'Refresh dashboard';

  @override
  String get dashboardLoadFailed =>
      'Unable to load dashboard data. Please try again.';

  @override
  String businessApprovedActivity(String name) {
    return 'Approved business: $name';
  }

  @override
  String businessSubmittedActivity(String name) {
    return 'New business submitted: $name';
  }

  @override
  String businessSuspendedActivity(String name) {
    return 'Suspended business: $name';
  }

  @override
  String revenueReceivedActivity(String amount) {
    return 'Revenue received: $amount';
  }

  @override
  String minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get yesterday => 'Yesterday';

  @override
  String get userManagement => 'User management';

  @override
  String get searchUsers => 'Search users';

  @override
  String get userRole => 'Role';

  @override
  String get allUsers => 'All users';

  @override
  String get investor => 'Investor';

  @override
  String get businessOwner => 'Business owner';

  @override
  String get userStatus => 'Status';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get userDetails => 'User details';

  @override
  String get viewUser => 'View user';

  @override
  String get suspend => 'Suspend';

  @override
  String get activate => 'Activate';

  @override
  String get changeUserStatus => 'Change user status';

  @override
  String changeUserStatusMessage(String name, String action) {
    return 'Are you sure you want to $action $name?';
  }

  @override
  String get noUsersFound => 'No users match your filters.';

  @override
  String get searchDeals => 'Search businesses or investors';

  @override
  String get dealStatus => 'Deal status';

  @override
  String get approved => 'Approved';

  @override
  String get rejected => 'Rejected';

  @override
  String get completed => 'Completed';

  @override
  String get dealDetails => 'Deal details';

  @override
  String get investmentAmount => 'Investment amount';

  @override
  String get expectedReturn => 'Expected return';

  @override
  String get viewDeal => 'View deal';

  @override
  String get noDealsFound => 'No deals match your filters.';

  @override
  String get approveProposalTitle => 'Approve proposal?';

  @override
  String approveProposalMessage(String business) {
    return 'Approve the investment proposal for $business?';
  }

  @override
  String get rejectProposalTitle => 'Reject proposal?';

  @override
  String rejectProposalMessage(String business) {
    return 'Reject the investment proposal for $business?';
  }

  @override
  String get dealActionSuccess => 'Deal proposal updated successfully.';

  @override
  String get dealActionFailed =>
      'Unable to update deal proposal. Please try again.';

  @override
  String get profitDistribution => 'Profit Distribution';

  @override
  String get totalProfit => 'Total profit';

  @override
  String get investorPayouts => 'Investor payouts';

  @override
  String get pendingPayouts => 'Pending payouts';

  @override
  String get searchProfitDistributions => 'Search businesses or investors';

  @override
  String get payoutStatus => 'Payout status';

  @override
  String get processing => 'Processing';

  @override
  String get paid => 'Paid';

  @override
  String get failed => 'Failed';

  @override
  String get investorYield => 'Investor yield';

  @override
  String get distributionDate => 'Distribution date';

  @override
  String get triggerPayout => 'Trigger payout';

  @override
  String get retryPayout => 'Retry payout';

  @override
  String get triggerPayoutTitle => 'Trigger payout?';

  @override
  String triggerPayoutMessage(String investor) {
    return 'Start the payout process for $investor?';
  }

  @override
  String get noProfitDistributions =>
      'No profit distributions match your filters.';

  @override
  String get profitLoadFailed =>
      'Unable to load profit distributions. Please try again.';

  @override
  String get payoutFailed => 'Unable to update the payout. Please try again.';

  @override
  String get reportsAnalytics => 'Reports & Analytics';

  @override
  String get platformVolume => 'Platform volume';

  @override
  String get dealSuccessRate => 'Deal success rate';

  @override
  String get totalUsers => 'Total users';

  @override
  String get newUsers => 'New users';

  @override
  String get platformRevenue => 'Platform revenue';

  @override
  String get volumeTrend => 'Platform volume trend';

  @override
  String get userGrowth => 'User growth';

  @override
  String get revenueTrend => 'Revenue trend';

  @override
  String get selectDateRange => 'Select date range';

  @override
  String get exportReport => 'Export report';

  @override
  String get chooseExportFormat => 'Choose an export format.';

  @override
  String reportExported(String fileName) {
    return 'Report generated: $fileName';
  }

  @override
  String get reportsLoadFailed =>
      'Unable to load analytics data. Please try again.';

  @override
  String get searchCategories => 'Search categories';

  @override
  String get addCategory => 'Add category';

  @override
  String get editCategory => 'Edit category';

  @override
  String get deleteCategory => 'Delete category';

  @override
  String get categoryName => 'Category name';

  @override
  String get categoryDescription => 'Description';

  @override
  String get categoryIcon => 'Icon name';

  @override
  String get categoryStatus => 'Category status';

  @override
  String get inactive => 'Inactive';

  @override
  String businessesCount(int count) {
    return '$count businesses';
  }

  @override
  String get categoryActionSuccess => 'Category updated successfully.';

  @override
  String get categoryActionFailed =>
      'Unable to update category. Please try again.';

  @override
  String get categoriesLoadFailed =>
      'Unable to load categories. Please try again.';

  @override
  String get noCategoriesFound => 'No categories match your search.';

  @override
  String get totalNotifications => 'Total notifications';

  @override
  String get sentNotifications => 'Sent notifications';

  @override
  String get totalRecipients => 'Total recipients';

  @override
  String get broadcastNotification => 'Broadcast notification';

  @override
  String get searchNotifications => 'Search notifications';

  @override
  String get recipientAudience => 'Recipient audience';

  @override
  String get allRecipients => 'All recipients';

  @override
  String get notificationStatus => 'Notification status';

  @override
  String get notificationSent => 'Sent';

  @override
  String get notificationPending => 'Pending';

  @override
  String get notificationFailed => 'Failed';

  @override
  String get notificationTitle => 'Title';

  @override
  String get notificationMessage => 'Message';

  @override
  String get sendNotification => 'Send notification';

  @override
  String get recipients => 'recipients';

  @override
  String get resend => 'Resend';

  @override
  String get noNotificationsFound => 'No notifications match your filters.';

  @override
  String get notificationsLoadFailed =>
      'Unable to load notifications. Please try again.';

  @override
  String get notificationActionFailed =>
      'Unable to send the notification. Please try again.';
}
