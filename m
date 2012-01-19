Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rnhxp-0000xE-Pd
 for kexec@lists.infradead.org; Thu, 19 Jan 2012 02:42:58 +0000
Message-ID: <4F17832E.9080102@sgi.com>
Date: Wed, 18 Jan 2012 18:42:54 -0800
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: kdump kernel tried to load modules not included in the kdump initrd?
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

I have a 2.6.32-131.6.1.el6 kernel, and kexec-tools-2.0.0-145.el6.x86_64
rpm on a cent6 machine.

When i forced a kdump by 'echo c > /proc/sysrq-trigger',
the kdump kernel panicked during the boot. Surprisingly,
it tried to load lustre modules that should not be part of
the initrd and panicked!

The syslog showed the --initrd specified a kdump.img
when kdump was started. I dumped out the kdump.img
and verified that no lustre module was included in the
initrd image.

So, how this have happened?

Thanks,
Jay


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
