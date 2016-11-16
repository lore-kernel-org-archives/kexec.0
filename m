Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6vem-0005QU-0k
 for kexec@lists.infradead.org; Wed, 16 Nov 2016 08:33:26 +0000
Received: by mail-oi0-f54.google.com with SMTP id b126so15622042oia.2
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2016 00:33:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E801D7@BPXM01GP.gisp.nec.co.jp>
References: <cover.1477378297.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7BD77@BPXM01GP.gisp.nec.co.jp>
 <CAHB_GuobH3=4_84D-DxcDRyXiV6WNWqQtMKTkKq+nn7vmGXyyA@mail.gmail.com>
 <CAHB_GupdvVhhajGAXKk37F9aDDOrX2W-5EY1SQ1VTqkmG3B8Ag@mail.gmail.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E801D7@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Date: Wed, 16 Nov 2016 14:03:02 +0530
Message-ID: <CAHB_Guow3Z-HEG3+Uwji-KWZ_ZGRLemnu2j4yjw6mn79mhV3mg@mail.gmail.com>
Subject: Re: [PATCH Makedumpfile 00/10] arm64 cleanup and kaslr support
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "sgoel@codeaurora.org" <sgoel@codeaurora.org>, "mansip@codeaurora.org" <mansip@codeaurora.org>, "asamson@codeaurora.org" <asamson@codeaurora.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Nov 16, 2016 at 11:14 AM, Atsushi Kumagai
<ats-kumagai@wm.jp.nec.com> wrote:
> Hello Pratyush,
>
>>On Tue, Nov 15, 2016 at 12:04 PM, Pratyush Anand <panand@redhat.com> wrote:
>>> Hi Atsushi,
>>>
>>> There would be a conflict because of following patch while applying
>>> these patches. Other than that I also see a an issue with --config
>>> option. So I will fix that as well and repost the series soon.
>>
>>Sorry, for the noise.That was a bad compilation of the code.
>>
>>Anyway, I resolved the conflict because of below patch in upstream
>>devel branch and r5pushed the patches in my git tree:
>>https://github.com/pratyushanand/makedumpfile.git : arm64_devel
>>
>>There is no changes other than conflict resolution w.r.t. this patch series.
>>
>>~Pratyush
>>
>>>
>>> 0068010b9b83 [PATCH v2 2/2] Clean up unused KERNEL_IMAGE_SIZE
>
> I'm sorry ! I misunderstood that I already pushed this series
> in the devel branch. Should I wait for v2 series where the
> conflict is resolved ?

As you wish. I can send v2 (there is no difference other than conflict
resolution for rebasing on top of current devel, conflict is minor),
or you can pick them from
https://github.com/pratyushanand/makedumpfile.git : arm64_devel.

I am OK with whatever is convenient for you.

Thanks
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
