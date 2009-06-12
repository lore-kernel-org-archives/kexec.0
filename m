Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wm58.inbox.com ([64.135.83.58])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MFCPs-0006tX-PJ
	for kexec@lists.infradead.org; Fri, 12 Jun 2009 19:28:05 +0000
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <906120000803.WM58> for <kexec@lists.infradead.org> from
	<dseetharam@inbox.com>; Fri, 12 Jun 2009 1:25:50 AM -0800
Mime-Version: 1.0
Date: Fri, 12 Jun 2009 01:25:49 -0800
Message-ID: <913DA90C6C8.0000039Bdseetharam@inbox.com>
From: Dharmosoth Seetharam <dseetharam@inbox.com>
Subject: /var/log/messages doesn't have crash info when kernel gets
	panic/oops/crash
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@lists.linux-foundation.org, vgoyal@in.ibm.com

Hi,

I have encounter a problem called /var/log/messages does not contain any information 
on kernel crash dump.

Prior to enabling KEXEC we saw stack traces and bug info etc in /var/log/messages.
After enabling KEXEC feature those info was missed.

How can we get those missed info in /var/log/messages even when KEXEC feature is enabled.

Any help will appreciate.


Thanks and Regards
Seetharam

____________________________________________________________
Receive Notifications of Incoming Messages
Easily monitor multiple email accounts & access them with a click.
Visit http://www.inbox.com/notifier and check it out!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
