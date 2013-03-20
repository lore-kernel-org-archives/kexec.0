Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]
 helo=am1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIIs9-0003fu-Hw
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 13:16:07 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
Date: Wed, 20 Mar 2013 13:15:55 +0000
Message-ID: <1363785354.2553.15.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <51490ABD.3050205@zytor.com>
In-Reply-To: <51490ABD.3050205@zytor.com>
Content-Language: en-US
Content-ID: <DC5092F7787488468759C704BBD7BF60@namprd05.prod.outlook.com>
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

On Tue, 2013-03-19 at 18:02 -0700, H. Peter Anvin wrote:

> Looking at it in detail, EVERYTHING in CAP_SYS_RAWIO has the possibility
> of compromising the kernel, because they let device drivers be bypassed,
> which means arbitrary DMA, which means you have everything.

Having checked again, I don't think this is true. The most obvious case
is libata, which uses CAP_SYS_RAWIO to limit the ability to send raw ATA
commands. Being able to do so clearly permits userspace to avoid any
kind of policy the vfs has put in place, but there's no obvious way for
the user to modify the running kernel. Are you suggesting that removing
the CAP_SYS_RAWIO check there would be reasonable?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
