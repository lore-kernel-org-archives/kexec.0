Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLHnM-0006CF-3d
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 19:48:03 +0000
Date: Wed, 5 Mar 2014 20:47:29 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 08/11] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20140305194729.GF28317@pd.tnic>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-9-git-send-email-vgoyal@redhat.com>
 <20140227213629.GP18191@pd.tnic>
 <20140228163134.GG28744@redhat.com>
 <20140305163722.GC28317@pd.tnic> <20140305184010.GC1740@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140305184010.GC1740@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Wed, Mar 05, 2014 at 01:40:10PM -0500, Vivek Goyal wrote:
> I thought Dave passed relevant information on bootparams and some in
> cmdline (I have not looked at details). Once the EFI support is in,
> kernel implementaion should do the same thing as kexec-tools is doing
> to pass EFI mapping information to second kernel.

Right, he reads the runtime map from sysfs:

Documentation/ABI/testing/sysfs-firmware-efi-runtime-map

How exactly he prepares it with kexec-tools I don't remember anymore - I
just skimmed over that part at the time.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
