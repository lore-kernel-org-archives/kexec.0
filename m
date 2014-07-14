Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X6fGZ-0007qO-Or
 for kexec@lists.infradead.org; Mon, 14 Jul 2014 12:22:00 +0000
Received: by mail-vc0-f177.google.com with SMTP id hy4so295715vcb.36
 for <kexec@lists.infradead.org>; Mon, 14 Jul 2014 05:21:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1405124388.4264.23.camel@smoke>
References: <CAFdej01jQFS3MrSdiQCWwv36qzG4L301w0iNJgGeunt-_44okA@mail.gmail.com>
 <CAFdej03ziTTA5QGFjzKd6Kc4skWNTr5RECy69qtnQGVtE6ks3w@mail.gmail.com>
 <1404931759.26155.70.camel@smoke>
 <CAFdej00cCymXM1wu31X7p6_Njy9sL-c7+k-v-+5jrmAuozsMng@mail.gmail.com>
 <1405124388.4264.23.camel@smoke>
Date: Mon, 14 Jul 2014 17:51:36 +0530
Message-ID: <CAFdej03yRkAg2oC40fEhB6faxbx9CnKf+15beXcHym0rA+_ZrQ@mail.gmail.com>
Subject: Re: Kexec on arm64
From: Arun Chandran <achandran@mvista.com>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

Hi Geoff,

On Sat, Jul 12, 2014 at 5:49 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun,
>
> On Fri, 2014-07-11 at 16:56 +0530, Arun Chandran wrote:
>> The below code fixes that issue (missing null check.
>
> I just pushed out a fix for this, slightly different
> from yours.  Please let me know if you still have a
> problem with it.
>

Got it. The loading part is fine with it.

kexec -e still giving troubles.


--Arun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
