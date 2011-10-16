Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bw0-f49.google.com ([209.85.214.49])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RFaUI-0000WK-Ks
	for kexec@lists.infradead.org; Sun, 16 Oct 2011 23:51:27 +0000
Received: by bkbc12 with SMTP id c12so7234210bkb.36
	for <kexec@lists.infradead.org>; Sun, 16 Oct 2011 16:51:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20111012224238.GE16825@verge.net.au>
References: <1317603918-30762-1-git-send-email-horms@verge.net.au>
	<CANqRtoT1ik9x+s10K6dBy34pDv5+up9dCweVF5MOctWeB=gxAw@mail.gmail.com>
	<20111012224238.GE16825@verge.net.au>
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 17 Oct 2011 08:50:58 +0900
Message-ID: <CABMQnV+zxWggFnxjVjy0kvk+r4a+kmSXyma5iPTQua0peq-UxQ@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Take into account the base of System RAM in
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
Cc: kexec@lists.infradead.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi,

2011/10/13 Simon Horman <horms@verge.net.au>:
> On Wed, Oct 12, 2011 at 05:24:23PM +0900, Magnus Damm wrote:
>> On Mon, Oct 3, 2011 at 10:05 AM, Simon Horman <horms@verge.net.au> wrote:
>> > Previously virt_to_phys() assumed that physical memory always started
>> > at address 0. This is not always the case.
>> >
>> > Tested on an sh7757lcr (32bit system) whose only System RAM region is
>> > 40000000-4effffff and an ecovec24 (29bit system).
>> >
>> > Signed-off-by: Simon Horman <horms@verge.net.au>
>> >
>> > ---
>> > =A0kexec/arch/sh/kexec-sh.c | =A0 45 +++++++++++++++++++++++++++++++++=
+++++++++++-
>> > =A01 files changed, 44 insertions(+), 1 deletions(-)
>> >
>> > v2
>> > * Only use the base of System RAM as an offset into physical memory
>> > =A0if 32bit addressing is in use.
>>
>> This version looks much better, thanks!
>
> I thought so too. But after pushing it I realised the parsing logic in
> is_32bit() is flawed. I will send an update.


yes, line of sscan does not work.
I think that the following is good if I easily make modifications.

while(fgets(line, sizeof(line), fp) !=3D 0) {
    if (!strcmp(line, "address sizes\t: 32 bits physical\n"))  {
        status =3D 1;
        break;
    }
}

Best regards,
  Nobuhiro


-- =

Nobuhiro Iwamatsu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
