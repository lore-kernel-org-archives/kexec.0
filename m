Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R8cY6-00019n-4N
	for kexec@lists.infradead.org; Tue, 27 Sep 2011 18:38:34 +0000
Message-ID: <4E821824.7090900@sgi.com>
Date: Tue, 27 Sep 2011 11:38:28 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: rhel5.6 kdump initrd problem?
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi all,

I have a system running 2.6.18-238.12.1.el5 kernel.
The kexec version is kexec-tools-1.102pre-126.el5_6.6.

The kernel was booted OK. Then it ran /etc/init.d/kdump
and a new kdump initrd image was created.
A kernel crash was triggered. The kdump kernel was booted
alright. However, it failed to boot when it tried to boot
back the regular kernel (now with the kdump initrd image
specified in the menu.lst.)

Has anyone else seen this problem?

Thanks,
Jay


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
