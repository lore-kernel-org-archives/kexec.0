Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqhYq-0007oz-9x
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 11:02:37 +0000
Received: by mail-qc0-f178.google.com with SMTP id i17so5069770qcy.9
 for <kexec@lists.infradead.org>; Wed, 11 Dec 2013 03:02:13 -0800 (PST)
Date: Wed, 11 Dec 2013 12:02:27 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: Re: [PATCH v5 02/14] efi: use early_memremap and early_memunmap
Message-ID: <20131211110227.GK22356@rocoto.smurfnet.nu>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-3-git-send-email-dyoung@redhat.com>
 <20131211103903.GC19196@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131211103903.GC19196@console-pimps.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, Mark Salter <msalter@redhat.com>, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Wed, Dec 11, 2013 at 10:39:03AM +0000, Matt Fleming wrote:
> Leif, Mark, does this patch look OK for ARM? We'd need to introduce a
> new early_memunmap() function so that things still build, but that
> should be straight forward. You'd even be able to get rid of the
> asymmetry in uefi_init() where you map efi.systab with early_memremap()
> but unmap it with early_iounmap().

This patch looks splendid for ARM. As long as Mark can get the new
function into an update to the early_*remap() set, I can include this
in my next version - which is coming this week.

/
    Leif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
