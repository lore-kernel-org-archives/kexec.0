Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-we0-f172.google.com ([74.125.82.172])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X25XD-0002FS-SB
 for kexec@lists.infradead.org; Tue, 01 Jul 2014 21:24:16 +0000
Received: by mail-we0-f172.google.com with SMTP id u57so10282870wes.3
 for <kexec@lists.infradead.org>; Tue, 01 Jul 2014 14:23:53 -0700 (PDT)
Date: Tue, 1 Jul 2014 22:23:51 +0100
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 15/15] kexec: Support kexec/kdump on EFI systems
Message-ID: <20140701212351.GK7539@console-pimps.org>
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <1403814824-7587-16-git-send-email-vgoyal@redhat.com>
 <20140701194605.GJ7539@console-pimps.org>
 <20140701131419.454a3fc32fcc84a43b668c50@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140701131419.454a3fc32fcc84a43b668c50@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, chaowang@redhat.com, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Tue, 01 Jul, at 01:14:19PM, Andrew Morton wrote:
> 
> This?
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: kexec-support-kexec-kdump-on-efi-systems-fix
> 
> s/get_efi/efi_get/g, per Matt
> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Matt Fleming <matt@console-pimps.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Yep, looks spot on. Thanks Andrew.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
