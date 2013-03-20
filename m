Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]
 helo=va3outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI7T9-0004RG-1G
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 01:05:32 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 06/12] x86: Require CAP_COMPROMISE_KERNEL for IO port
 access
Date: Wed, 20 Mar 2013 01:05:23 +0000
Message-ID: <2ad7xmbpwcl9vgjowbcqr2uu.1363741519451@email.android.com>
Content-Language: en-US
Content-ID: <F37F080076B17A4F8ED37F7CE6790867@nebula.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Easiest way to do that would be to replace some existing users of CAP_RAW_IO with CAP_SYS_ADMIN and then just insert a couple of extra RAW_IO checks. That would break some existing userspace, but so would introducing a new capability. I'm happy to go that way, but would appreciate some broader feedback that that's the way to go. 
-- 
Matthew Garrett | matthew.garrett@nebula.com
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
