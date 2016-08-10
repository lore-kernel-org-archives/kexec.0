Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXKOb-0007CH-FP
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 03:41:34 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
In-Reply-To: <3544655.o5QPxko4Ba@hactar>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
Date: Wed, 10 Aug 2016 13:41:08 +1000
Message-ID: <87r39xthnv.fsf@concordia.ellerman.id.au>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
>> On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
>> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> > > diff --git a/security/integrity/ima/ima.h
>> > > b/security/integrity/ima/ima.h
>> > > index b5728da..84e8d36 100644
>> > > --- a/security/integrity/ima/ima.h
>> > > +++ b/security/integrity/ima/ima.h
>> > > @@ -102,6 +102,13 @@ struct ima_queue_entry {
>> > > 
>> > >  };
>> > >  extern struct list_head ima_measurements;	/* list of all 
> measurements
>> > >  */
>> > > 
>> > > +/* Some details preceding the binary serialized measurement list */
>> > > +struct ima_kexec_hdr {
>> > > +	unsigned short version;
>> > > +	unsigned long buffer_size;
>> > > +	unsigned long count;
>> > > +} __packed;
>> > > +
>> > 
>> > Am I understanding it correctly that this structure is passed between
>> > kernels?
>> Yes, the header prefixes the measurement list, which is being passed on
>> the same computer to the next kernel.  Could the architecture (eg.
>> LE/BE) change between soft re-boots?
>
> Yes. I am able to boot a BE kernel from an LE kernel with my patches. 
> Whether we want to support that or not is another question...

Yes you must support that. BE -> LE and vice versa.

You should also consider the possibility that the next kernel is not
Linux.

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
