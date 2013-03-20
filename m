Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI7OL-00039J-Jh
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 01:00:34 +0000
Message-ID: <51490A22.1080908@zytor.com>
Date: Tue, 19 Mar 2013 18:00:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 06/12] x86: Require CAP_COMPROMISE_KERNEL for IO port
 access
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <1363642353-30749-6-git-send-email-matthew.garrett@nebula.com>
In-Reply-To: <1363642353-30749-6-git-send-email-matthew.garrett@nebula.com>
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
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: linux-pci@vger.kernel.org, linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 03/18/2013 02:32 PM, Matthew Garrett wrote:
> IO port access would permit users to gain access to PCI configuration
> registers, which in turn (on a lot of hardware) give access to MMIO register
> space. This would potentially permit root to trigger arbitrary DMA, so lock
> it down by default.
> 

Again, if you are going to do this, just kill bloody RAWIO.  Quite
frankly saying brainfucked SCSI drivers have abused it doesn't hold
water, because as far as you know those same commands can trigger
arbitrary DMA activity.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
