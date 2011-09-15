Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]
	helo=ch1outboundpool.messaging.microsoft.com)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R4EgJ-0000DD-QY
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 16:20:57 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: vmcore_init() failure using uImage on fsl_booke
Date: Thu, 15 Sep 2011 16:20:31 +0000
Message-ID: <CAEsOVNczdWMhJApFL19Uuy6rmY0G8JZg5DOs4mntgEjrVdr3tQ@mail.gmail.com>
References: <D58A856745AB5A47B1448181D1A8BBFA0F6195C855@EUSAACMS0701.eamcs.ericsson.se>
	<CAEsOVNcbaUH3nEay4qgWv9tU7oSqsBvkAN136m7DVQpqijXT3A@mail.gmail.com>
	<D58A856745AB5A47B1448181D1A8BBFA0F6195D0FD@EUSAACMS0701.eamcs.ericsson.se>
	<CAJGZr0+kDKzMewfwJ1c=xd6-cmTtY4UP3GYECqRxh=u=Nfw32g@mail.gmail.com>
In-Reply-To: <CAJGZr0+kDKzMewfwJ1c=xd6-cmTtY4UP3GYECqRxh=u=Nfw32g@mail.gmail.com>
Content-Language: en-US
Content-ID: <7E764E669AB4E844BED34C2C42DB05EA@freescale.net>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: Dennis Flynn <dennis.flynn@ericsson.com>, McClintock Matthew-B29882 <B29882@freescale.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Sep 15, 2011 at 11:13 AM, Maxim Uvarov <muvarov@gmail.com> wrote:
> 2011/9/15 Dennis Flynn <dennis.flynn@ericsson.com>:
>>
>>> I assume this is 512M?
>> Yes, 512M.
>>
>>> It appears to have allocated a segment at this address. Can you try adding debug statements to exec to see the contents of this segment? I suspect kexec is loading nothing since it does not have an ELF header to load for the uImage case.
>>
>> I added code to default_machine_kexec() to ioremap the segment[2].mem physical address and then use print_hex_dump() to dump the contents of this segment. Looks like the ELF header signature is present. Just not visible via /dev/oldmem from the crash kernel?
>>
>
> But should /dev/oldmem have elf header? As I remember it is
> constructing when you read from /proc/vmcore.

It seems logical that /dev/oldmem should not require anything except
the old memory not to be modified. So, in any case this should not be
a fatal error, right?

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
