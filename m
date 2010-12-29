Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PXrX3-0005z4-A5
	for kexec@lists.infradead.org; Wed, 29 Dec 2010 08:37:22 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <4D18F798.4010708@zytor.com> <20101228000651.GB4142@redhat.com>
	<4D192BC3.8040802@zytor.com> <m1lj3auyzr.fsf@fess.ebiederm.org>
	<4D1A4469.2060000@zytor.com> <m1ei91usg1.fsf@fess.ebiederm.org>
	<4D1AD463.9050202@zytor.com>
Date: Wed, 29 Dec 2010 00:37:04 -0800
In-Reply-To: <4D1AD463.9050202@zytor.com> (H. Peter Anvin's message of "Tue,
	28 Dec 2010 22:25:39 -0800")
Message-ID: <m1tyhxt1ov.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: How does kdump deal with trampoline allocation?
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 12/28/2010 08:13 PM, Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>>
>>> Well, the trampoline is optional only on 32 bits, and with my changes,
>>> it would be unconditional.
>> 
>> What motivates your trampoline rewrite?
>> 
>
> The fact that so far four different pieces of code have low memory
> trampolines, and each is implemented differently.  Furthermore, I'm
> currently being forced to work on a fifth.  This unifies all that code,
> but it also makes it unconditional since at least reboot=bios is always
> going to need to be there.

That makes some sense.  I remember seeing your complaining about how
many different flavors of physical page tables we have.

When your patches are ready cc me and I will be happy to look them
over and see if I can spot anything you might have missed.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
