Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TA5BC-0002z5-Lt
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 20:29:31 +0000
Message-ID: <504A5927.2090605@hp.com>
Date: Fri, 07 Sep 2012 14:29:27 -0600
From: Khalid Aziz <khalid.aziz@hp.com>
MIME-Version: 1.0
Subject: Re: Problem with kexec on i386, linux-3.5
References: <500EE046.2000705@gmx.at>
In-Reply-To: <500EE046.2000705@gmx.at>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?ISO-8859-1?Q?Christian_Schaubschl=E4ger?= <christian.schaubschlaeger@gmx.at>
Cc: kexec@lists.infradead.org

On 07/24/2012 11:49 AM, Christian Schaubschl=E4ger wrote:
> Hello list,
>
> I'm not sure if this is the correct place to post this; if it's not, =

> I'd like to apologize.
>
> Here's a short description of my problem:
>
> I have a tiny protected-/real mode program, which I start using kexec =

> (kexec-tools 2.0.3 released 05 April 2012). At some point this program =

> makes a call to extended-int13 to read data from the disk. Now =

> starting with linux-3.5-rc1 (and at least up to linux-3.5) this =

> extended int13 call does not work any more. Apparently the call =

> returns with error code 0x80, which means "timeout (not ready)".
>
> I have two machines here, both with Intel chipsets (one CougarPoint, =

> one older ICH7-M), and I see the same behaviour on both machines.
>
> When I use older kernels (starting from 2.6.something up to 3.4.6), =

> everything works fine.
>
> Now I'm not sure if this is a kernel issue, or a kexec issue, or a =

> mistake by myself. Maybe someone has a hint for me...
>
> If required, of course, I can provide more detailed information about =

> my hardware, kernel config, etc. (since I'm not sure if this is the =

> correct place, I wanted to keep this message short for now).
>

Hello Christian,

Are you not loading the driver for your disk drive controller when the =

new kernel boots up, even though you are not using the driver for disk =

I/O? If yes, the driver should have re-enabled Bus Master bit in its =

init routine. If you are loading the driver, which driver is it? I can =

take a look at it and see if there is anything missing in the =

initialization routine. Can you also include output from "lspci -v" from =

your machine?

Thanks
-- =

Khalid

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
