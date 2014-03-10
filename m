Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WMx2A-0008Vx-Fr
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 10:02:12 +0000
Date: Mon, 10 Mar 2014 11:01:43 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 09/11] kexec: Provide a function to add a segment at
 fixed address
Message-ID: <20140310100143.GA14808@pd.tnic>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-10-git-send-email-vgoyal@redhat.com>
 <20140227215232.GQ18191@pd.tnic>
 <20140228165628.GH28744@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140228165628.GH28744@redhat.com>
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

On Fri, Feb 28, 2014 at 11:56:28AM -0500, Vivek Goyal wrote:
> This is more of future proofing it. I have been putting this check to
> catch any accidental errors if somebody ends up calling this function
> from old mode.
> 
> But I am not very particular about it. If you don't like it, I can get
> rid of it.

Yeah, it doesn't hurt to be overly cautious - I guess it can be removed
later when this code settles.

> I think address does not matter here. You can't add a segemnt after you
> have allocated a control page. So I am not sure how printing address will
> help.

Ok, so what's the urgency of that warning? The "can't add a segment"
thing sounds kinda final to me and that everything breaks if we do add a
segment after all, so maybe it should error out with -EINVAL and caller
should stop adding segments if we have allocated the control page..?

IOW, how is that error message supposed to help me when I see it as a
user?

> Ok, there is not much difference between two, but I can use PAGE_ALIGN().

Yeah, they're the same thing but the name PAGE_ALIGN is more descriptive
:-)

> > That's the retval of validate_ram_range_callback, right? So
> > 
> > 	if (!ret)
> > 
> > And shouldn't the convention be the opposite? 0 on success, !0 on error?
> 
> Ok, this one is little twisted.
> 
> walk_system_ram_res() stops calling callback function if callback
> function returned non zero code.
> 
> So in this case, once we have found the range to be valid, we don't want
> to continue to loop and look at any more ranges. So we return "1". If
> we return "0" for success, outer loop of walk_system_ram_res() will
> continue with next ranges.

Huh, I was only talking about flipping that logic, in walk_system_ram_res():

	ret = (*func)(res.start, res.end, arg);
	if (!res)
		break;

This way you still can return negative values as errors.

> Given the fact that "0" is interpreted as success by walk_system_ram_res()
> and it continues with next set of ranges, I could not use 0 as final
> measure of success. Negative returns are errors. So I thought of using

And?

When the loop finishes, you will have the last negative error in ret...

Besides, in load_crashdump_segments() you have:

        ret = walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
                                image, determine_backup_region);

        /* Zero or postive return values are ok */
        if (ret < 0)
                return ret;

So 0 is ok, as you say.

Also:

        /* Validate memory range */
        ret = walk_system_ram_res(base, base + memsz - 1, &ksegment,
                                validate_ram_range_callback);

        /* If a valid range is found, 1 is returned */
        if (ret != 1)
                return -EINVAL;

Now this looks a bit fragile - only 1 is ok? Normally we do it like this:

	if (ret)
		return ret;

	return __kexec_add_segment(...)


and this way you can propagate the error value up without rewriting it
here.

Am I missing something here?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
