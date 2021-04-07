Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam12on2111.outbound.protection.outlook.com
 ([40.107.244.111] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUBdu-005Zxo-RY
 for kexec@lists.infradead.org; Wed, 07 Apr 2021 17:07:05 +0000
Date: Wed, 7 Apr 2021 13:06:55 -0400
From: Joe Korty <joe.korty@concurrent-rt.com>
Subject: [BUG] kexec-tools blows up when the kernel is 4.4.262
Message-ID: <20210407170655.GA35080@zipoli.concurrrent-rt.com>
Content-Disposition: inline
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

The following lines in kexec/kernel_version.c cause a crash dump to fail,
when the kernel is 4.4.262, or indeed any kernel whose patchlevel is >255.

	if (major >= 256 || minor >= 256 || patch >= 256) {
		fprintf(stderr, "Unsupported utsname.release: %s\n",
			utsname.release);
		return -1;
	}

	return KERNEL_VERSION(major, minor, patch);

Regards,
Joe

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
