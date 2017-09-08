Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dq9yJ-0001st-Ec
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 03:28:53 +0000
Received: by mail-pg0-f51.google.com with SMTP id t3so2841700pgt.0
 for <kexec@lists.infradead.org>; Thu, 07 Sep 2017 20:28:26 -0700 (PDT)
Subject: Re: Fwd: zImage support for ppc
References: <CALKbUJQCd3C1NPxXba5jb9QYPUbEYNnx_dywxTsP+Rnejbt6YA@mail.gmail.com>
 <CALKbUJTmkJV-bq1mnzqR5Q-RrX6OpSniTZd=z26QxqtJttPVMg@mail.gmail.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <cdbaee7b-0173-5171-67ec-5f685c16776d@redhat.com>
Date: Fri, 8 Sep 2017 08:58:22 +0530
MIME-Version: 1.0
In-Reply-To: <CALKbUJTmkJV-bq1mnzqR5Q-RrX6OpSniTZd=z26QxqtJttPVMg@mail.gmail.com>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sunil Kumar <sukumar@mvista.com>, kexec@lists.infradead.org



On Thursday 07 September 2017 01:49 PM, Sunil Kumar wrote:
> $ kexec -e
> 
> As the zImage is also and elf file format, but the control is not
> getting transferred to the zImage.
> I can see kexec is able to load all the segments properly, but looks
> like its not able to figure out the entry point to start execution
> with zImage.
> -------------------------------------------------------------------------------------------------------------------------------------------------------
> kexec_load: entry = 0x329678 flags = 0x0
> -------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> On the same board (i.e. Freescale p2020ds), uImage and vmlinux works fine.

Looking into upstream code: ppc has only support of elf and uImage,and so they 
work.

> 
> Just curious to know , why the zImage support is still not provided in
> the kexec for ppc ??

Probably because no one needed it till now.

> Is there any restriction from kexec design point of view ?

I do not think. You can write a patch. I see, ppc64 has zImage support, so you 
can take that as example and can write code for ppc as well.

-- 
Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
