Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R5sCn-0007S2-3Q
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 04:45:14 +0000
Received: by ewy7 with SMTP id 7so32951ewy.20
	for <kexec@lists.infradead.org>; Mon, 19 Sep 2011 21:45:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110917081129.GB22218@verge.net.au>
References: <1316085179-4207-1-git-send-email-horms@verge.net.au>
	<CANqRtoSa-Bk-QAdfzHQra8WTe93Qp=yMMm5Z81zYnHo7t158Bw@mail.gmail.com>
	<20110917081129.GB22218@verge.net.au>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 20 Sep 2011 13:44:43 +0900
Message-ID: <CABMQnVL0bd956U5GWuBcW9CEMY9v6hksGL-iH52_1uihcwnk2A@mail.gmail.com>
Subject: Re: [RFC] sh: Take into account the base of physical memory in
	virt_to_phys()
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi, all.

I forgot to have sent the following patches to solve the same problem.
  http://www.spinics.net/lists/linux-sh/msg05954.html

I was going to add the mode which worked to proc/cpuinfo.
Because the user did not know whether a kernel was 29bit or 32bit from
the user space.

Paul, do you think so?

Best regards,
  Nobuhiro

2011/9/17 Simon Horman <horms@verge.net.au>:
> On Fri, Sep 16, 2011 at 07:59:21PM +0900, Magnus Damm wrote:
>> On Thu, Sep 15, 2011 at 8:12 PM, Simon Horman <horms@verge.net.au> wrote:
>> > Previously virt_to_phys() assumed that physical memory always started
>> > at address 0. This is not always the case.
>>
>> I think most boards have NOR Flash or ROM mapped at physical address 0.
>>
>> For more information please have a look at: arch/sh/boards/mach-ecovec24=
/setup.c
>>
>> > --- a/kexec/arch/sh/kexec-sh.c
>> > +++ b/kexec/arch/sh/kexec-sh.c
>> > @@ -188,10 +188,18 @@ void kexec_sh_setup_zero_page(char *zero_page_bu=
f, size_t zero_page_size,
>> > =A0unsigned long virt_to_phys(unsigned long addr)
>> > =A0{
>> > =A0 =A0 =A0 =A0unsigned long seg =3D addr & 0xe0000000;
>> > + =A0 =A0 =A0 unsigned long long start, end;
>> > + =A0 =A0 =A0 int ret;
>> > +
>> > + =A0 =A0 =A0 /* Assume there is only one "System RAM" region */
>> > + =A0 =A0 =A0 ret =3D parse_iomem_single("System RAM\n", &start, &end);
>> > + =A0 =A0 =A0 if (ret)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Could not parse System RAM region i=
n /proc/iomem\n");
>> > +
>> > =A0 =A0 =A0 =A0if (seg !=3D 0x80000000 && seg !=3D 0xc0000000)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Virtual address %p is not in P1 or=
 P2\n", (void *)addr);
>> >
>> > - =A0 =A0 =A0 return addr - seg;
>> > + =A0 =A0 =A0 return addr - seg + start;
>> > =A0}
>>
>> This will most likely also change how 29-bit platforms translate their
>> addresses, not sure if that's what you want to do.
>
> I am also unsure about the 29bit case. Do you have any thoughts on
> what a good approach might look like?
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



-- =

Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
