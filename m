Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wwdyq-0005w8-Cj
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 20:58:17 +0000
Date: Mon, 16 Jun 2014 22:57:43 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 11/13] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20140616205743.GI8170@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-12-git-send-email-vgoyal@redhat.com>
 <20140615163515.GA17016@pd.tnic> <20140616200608.GD4515@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140616200608.GD4515@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Mon, Jun 16, 2014 at 04:06:08PM -0400, Vivek Goyal wrote:
> There can be more than one loader and the one which claims first
> to recognize the image will get to load the image. So once 32 bit
> loader support comes in, it might happen that we ask 64bit loader
> first and it rejects the image and then we ask 32bit loader.

What does that have to do with anything??

> So these message are really debug message which tells why loader
> is not accepting an image. It might not be image destined for that
> loader at all.
> 
> pr_debug() allows being verbose if user wants to for debugging purposes.
> You just have to make sure that CONFIG_DYNAMIC_DEBUG=y and enable verbosity
> in individual file.
> 
> echo 'file kexec-bzimage.c +p' > /sys/kernel/debug/dynamic_debug/control

So people are supposed to enable dynamic_debug just so that they see
*why* their image doesn't load.

Doesn't sound optimal to me.

> Same here. We will potentially be trying multiple loaders and if every
> loader prints messages for rejection by default, it is too much of
> info, IMO.

For max two loaders on one architecture? I don't think so. Now you're
just arguing for the sake of it.

> I like doing memory allocations early in the functions (as far as
> possible) and error out if need be. If memory is available to begin
> with for all the data structures needed by this function, it is kind
> of pointless to do rest of the processing.

We're talking about memory for a single void * which is ridiculous. And
I think simplifying the error paths is a much higher win than doing some
minor allocation.

> Hmm..., If you feel strongly about it, I can make this change. I
> thought I just made it easier to share the code between 32bit and
> 64bit by this.

Someone later can do that - right now this code is 64-bit only as far as
we're concerned and if it can be made to work on 32-bit, then people are
free to do so.

> I think it just makes it safer that we don't try to copy more than
> size of destination, in case ->eddbuf_entries is not right or corrupted.
> 
> I see copy_edd() does similar thing.
> 
> memcpy(edd.edd_info, boot_params.eddbuf, sizeof(edd.edd_info));
> edd.edd_info_nr = boot_params.eddbuf_entries;
> 
> So may be it is not a bad idea to copy based on max size of data
> structures.

Ok, makes sense.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
