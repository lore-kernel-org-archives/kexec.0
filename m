Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VrYyb-0007qL-Rz
 for kexec@lists.infradead.org; Fri, 13 Dec 2013 20:04:48 +0000
Date: Fri, 13 Dec 2013 21:04:12 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 12/14] x86: export x86 boot_params to sysfs
Message-ID: <20131213200412.GA12466@pd.tnic>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-13-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386582147-9802-13-git-send-email-dyoung@redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Mon, Dec 09, 2013 at 05:42:25PM +0800, Dave Young wrote:
> kexec-tools use boot_params for getting the 1st kernel hardware_subarch,
> the kexec kernel efi runtime support also need read the old efi_info from
> boot_params. Currently it exists in debugfs which is not a good place for
> such infomation. Per HPA, we should avoid of "sploit debugfs".
> 
> In this patch /sys/kernel/boot_params are exported, also the setup_data is
> exported as a subdirectory. kexec-tools is using debugfs for hardware_subarch
> for a long time now so we're not removing it yet.
> 
> Structure is like below:
> 
> /sys/kernel/boot_params
> |__ data                /* boot_params in binary*/
> |__ setup_data
> |   |__ 0               /* the first setup_data node */
> |   |   |__ data        /* setup_data node 0 in binary*/
> |   |   |__ type        /* setup_data type of setup_data node 0, hex string */
> [snip]
> |__ version             /* boot protocal version (in hex, "0x" prefixed)*/
> 
> Changelog:
> Greg: use __ATTR_RO() and group attr.
> Matt and Boris: Documentation improvement, code indentation.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
