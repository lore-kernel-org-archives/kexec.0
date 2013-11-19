Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VikGQ-0005wf-Cy
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 12:18:43 +0000
Date: Tue, 19 Nov 2013 12:18:14 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 5/7 v2] export efi runtime memory mapping to sysfs
Message-ID: <20131119121814.GB11521@console-pimps.org>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082718.185728964@dhcp-16-126.nay.redhat.com>
 <20131113155027.GC17248@console-pimps.org>
 <20131114015047.GD4081@dhcp-16-126.nay.redhat.com>
 <20131118021641.GC4025@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131118021641.GC4025@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Mon, 18 Nov, at 10:16:41AM, Dave Young wrote:
> Matt, desc_version is already in boot_params.efi_info, so kexec-tools
> can get the version from there. I do not need to export it as another
> file.
 
OK, cool.

> I think for now we do not need worry much about the compatibility
> issue, do you think I need add version checking in kexec-tools
> currently? like below?
> 
> if (desc_version != 1) /* current version is 1? */
> 	error out it is not supported

Yes, something like that. If you already have kexec-specific ways of
checking a version number then that's fine. Just make sure that, if the
EFI memory descriptor structure is extended in the future and more files
are exported for each descriptor, kexec-tools say "I don't know how to
build a data structure for from these files".

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
