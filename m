Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbajA-0005Jd-88
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 17:38:17 +0000
Message-ID: <50AE62E9.3000602@zytor.com>
Date: Thu, 22 Nov 2012 09:37:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com>
In-Reply-To: <87txshx28b.fsf@xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, tglx@linutronix.de

On 11/22/2012 04:15 AM, Eric W. Biederman wrote:
>
> Let me be clear.  kexec_ops as you have implemented it is absolutely
> unacceptable.
>
> Your kexec_ops is not an abstraction but a hack that enshrines in stone
> implementation details.
>

This is the kind of stuff that is absolutely endemic to the Xen 
endeavour, and which is why Xen is such a disease.  The design principle 
seems to have been "hey, let's go and replace random Linux kernel 
internals with our own stuff, and make them ABIs, so that they can never 
change.  Oh, and let's not bother documenting the constraints we're 
imposing, that might make the code manageable."

I actually talked to Ian Jackson at LCE, and mentioned among other 
things the bogosity of requiring a PUD page for three-level paging in 
Linux -- a bogosity which has spread from Xen into native.  It's a page 
wasted for no good reason, since it only contains 32 bytes worth of 
data, *inherently*.  Furthermore, contrary to popular belief, it is 
*not* pa page table per se.

Ian told me: "I didn't know we did that, and we shouldn't have to." 
Here we have suffered this overhead for at least six years, because *XEN 
FUCKED UP AND NOONE ELSE HAD ANY WAY OF KNOWING THAT*.

Now we know that it can "maybe"(!!!) be fixed, if we are willing to 
spend time working on a dying platform, whereas we have already suffered 
the damage during the height of its importance.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
