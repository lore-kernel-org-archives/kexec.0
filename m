Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ztshx-0005bS-Ci
 for kexec@lists.infradead.org; Wed, 04 Nov 2015 07:42:14 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH V7] makedumpfile: exclude page structures of non-dumped
 pages
Date: Wed, 4 Nov 2015 07:33:24 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DF9438@BPXM01GP.gisp.nec.co.jp>
References: <20151026142012.E8F891386E2F@asylum.americas.sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DF7B34@BPXM01GP.gisp.nec.co.jp>
 <20151028110402.GA31991@sgi.com>
In-Reply-To: <20151028110402.GA31991@sgi.com>
Content-Language: ja-JP
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Wed, Oct 28, 2015 at 04:38:24AM +0000, Atsushi Kumagai wrote:
>> Hello Cliff,
>>
>> >From: Cliff Wickman <cpw@sgi.com>
>> >
>> >Applies to the development branch as of 10/13/2015.
>> >Incorporates review 10/22 by kumagai-atsushi.
>> >Incorporates review 10/26 by kumagai-atsushi. (arch x86_64-only implementation)
>>
>> Thanks for your great work.
>> I don't want to delay v1.5.9 release anymore, I'll merge this patch
>> into v1.6.0.
>
>Great!
>Thanks for your long and patient help in defining the extent of this patch
>and sanding off its rough edges.

BTW, I think you might be doing this, you should post a crash's patch to
support DUMP_DH_EXCLUDED_VMEMMAP as Dave said, until this feature is
released formally in v1.6.0.

  http://lists.infradead.org/pipermail/kexec/2015-October/014600.html


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
