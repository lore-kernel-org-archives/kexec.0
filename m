Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZuVLj-0005n0-3x
 for kexec@lists.infradead.org; Fri, 06 Nov 2015 00:57:52 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH V7] makedumpfile: exclude page structures of non-dumped
 pages
Date: Fri, 6 Nov 2015 00:55:48 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DF9DE0@BPXM01GP.gisp.nec.co.jp>
References: <mailman.1817.1446622935.1639.kexec@lists.infradead.org>
 <2105561780.4751780.1446645262529.JavaMail.zimbra@redhat.com>
In-Reply-To: <2105561780.4751780.1446645262529.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> >> Thanks for your great work.
>> >> I don't want to delay v1.5.9 release anymore, I'll merge this patch
>> >> into v1.6.0.
>> >
>> >Great!
>> >Thanks for your long and patient help in defining the extent of this patch
>> >and sanding off its rough edges.
>>
>> BTW, I think you might be doing this, you should post a crash's patch to
>> support DUMP_DH_EXCLUDED_VMEMMAP as Dave said, until this feature is
>> released formally in v1.6.0.
>>
>>   http://lists.infradead.org/pipermail/kexec/2015-October/014600.html
>>
>> Thanks,
>> Atsushi Kumagai
>
>Hi Atsushi,
>
>Since I didn't get a response to either of my posts re: the above, when
>I saw the patch go into your devel branch, I went ahead and added a patch
>for crash-7.1.4:
>
>  https://github.com/crash-utility/crash/commit/7ce8469f8bf7e32017f8270ecd22469040817ba2
>
>Thanks,
>  Dave

Hello Dave,

Oh I overlooked it, thanks for your help !

Regards,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
