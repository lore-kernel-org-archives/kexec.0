Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MFD0B-0004bo-2Y
	for kexec@lists.infradead.org; Fri, 12 Jun 2009 20:05:45 +0000
Date: Fri, 12 Jun 2009 16:05:13 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: /var/log/messages doesn't have crash info when kernel gets
	panic/oops/crash
Message-ID: <20090612200513.GA2953@hmsreliant.think-freely.org>
References: <913DA90C6C8.0000039Bdseetharam@inbox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <913DA90C6C8.0000039Bdseetharam@inbox.com>
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
To: Dharmosoth Seetharam <dseetharam@inbox.com>
Cc: fastboot@lists.linux-foundation.org, vgoyal@in.ibm.com, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, Jun 12, 2009 at 01:25:49AM -0800, Dharmosoth Seetharam wrote:
> Hi,
> 
> I have encounter a problem called /var/log/messages does not contain any information 
> on kernel crash dump.
> 
> Prior to enabling KEXEC we saw stack traces and bug info etc in /var/log/messages.
> After enabling KEXEC feature those info was missed.
> 
> How can we get those missed info in /var/log/messages even when KEXEC feature is enabled.
> 
> Any help will appreciate.
> 
run crash on the resultant vmcore file that kexec can produce/save and get the
dmesg log out of it.
alternatively you can use makedumpfile with the --dump-dmesg log

Neil

> 
> Thanks and Regards
> Seetharam
> 
> ____________________________________________________________
> Receive Notifications of Incoming Messages
> Easily monitor multiple email accounts & access them with a click.
> Visit http://www.inbox.com/notifier and check it out!
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
