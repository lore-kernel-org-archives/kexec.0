Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eg1QU-0005Ml-LK
 for kexec@lists.infradead.org; Mon, 29 Jan 2018 04:52:16 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH v2] Wipe excluded pages that are written
 into ELF dump file
Date: Mon, 29 Jan 2018 04:51:22 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F418BA@BPXM01GP.gisp.nec.co.jp>
References: <1501848839-10518-1-git-send-email-eric.devolder@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EF7308@BPXM01GP.gisp.nec.co.jp>
 <5db0222a-f550-9007-2775-15f6e8b92f0b@oracle.com>
In-Reply-To: <5db0222a-f550-9007-2775-15f6e8b92f0b@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Eric,

>On 08/07/2017 07:25 PM, Atsushi Kumagai wrote:
>> Hello Eric,
>>
>> Thanks for your work, this version looks good to me.
>> I'll merge this into v1.6.3.
>>
>> Regards,
>> Atsushi Kumagai
>
>Thank you!
>eric

I noticed that wiping zero pages seems to cause different behavior
of crash like:

[kmem -i]
-    SWAP USED        1         4 KB    0% of TOTAL SWAP
-    SWAP FREE   489979       1.9 GB   99% of TOTAL SWAP
+    SWAP USED   229886       898 MB   46% of TOTAL SWAP  // wiped page is counted as SWAP USED ?
+    SWAP FREE   260094      1016 MB   53% of TOTAL SWAP

I don't investigate the details yet, but I decided to slip this
feature to v1.6.4.

Thanks,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
