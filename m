Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([103.22.144.67])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXQBc-0008KK-NO
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 09:52:33 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
In-Reply-To: <18857164.IzlezsQllh@hactar>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <3544655.o5QPxko4Ba@hactar> <87r39xthnv.fsf@concordia.ellerman.id.au>
 <18857164.IzlezsQllh@hactar>
Date: Wed, 10 Aug 2016 19:52:09 +1000
Message-ID: <87vaz9rlx2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Mittwoch, 10 August 2016, 13:41:08 schrieb Michael Ellerman:
>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>> > Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
>> >> On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
>> >> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes: 
>> >> > > +/* Some details preceding the binary serialized measurement list
>> >> > > */
>> >> > > +struct ima_kexec_hdr {
>> >> > > +	unsigned short version;
>> >> > > +	unsigned long buffer_size;
>> >> > > +	unsigned long count;
>> >> > > +} __packed;
>> >> > > +
>> >> > 
>> >> > Am I understanding it correctly that this structure is passed between
>> >> > kernels?
>> >> 
>> >> Yes, the header prefixes the measurement list, which is being passed on
>> >> the same computer to the next kernel.  Could the architecture (eg.
>> >> LE/BE) change between soft re-boots?
>> > 
>> > Yes. I am able to boot a BE kernel from an LE kernel with my patches.
>> > Whether we want to support that or not is another question...
>> 
>> Yes you must support that. BE -> LE and vice versa.
>
> I didn't test BE - LE yet, but will do.

Thanks.

>> You should also consider the possibility that the next kernel is not
>> Linux.
>
> If the next kernel is an ELF binary and it supports the kexec "calling 
> convention", it should work too. What could possibly go wrong? I can try 
> FreeBSD (I suppose it's an ELF kernel) and see what happens.

At least for old style kexec (not sys_kexec_load()) I don't think it
even needs to be an ELF binary.

I think there are folks working on FreeBSD (or $?BSD), so I think the
basic kexec part works.

There's nothing (yet) that wants to use this measurement list obviously,
but it should be designed such that it could be used by an unknown
future kernel that knows the ABI.

So given what you have above, you'd use something like:

struct ima_kexec_hdr {
	u16 version;
	u16 _reserved0;
	u32 _reserved1;
	u64 buffer_size;
	u64 count;
};

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
