Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFVrX-0007c3-6j
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 00:17:48 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v2] makedumpfile: support _count -> _refcount rename in
 struct page
Date: Wed, 22 Jun 2016 00:15:26 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E4D1A1@BPXM01GP.gisp.nec.co.jp>
References: <1466156479-9659-1-git-send-email-vkuznets@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E4CE36@BPXM01GP.gisp.nec.co.jp>
 <20160621064508.GD29309@dhcppc9> <87k2hjhsq1.fsf@vitty.brq.redhat.com>
 <20160621100329.GE29309@dhcppc9> <8737o6j0ar.fsf@vitty.brq.redhat.com>
In-Reply-To: <8737o6j0ar.fsf@vitty.brq.redhat.com>
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Pratyush Anand <panand@redhat.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Anderson <anderson@redhat.com>

>Pratyush Anand <panand@redhat.com> writes:
>
>> On 21/06/2016:10:05:42 AM, Vitaly Kuznetsov wrote:
>>> Pratyush Anand <panand@redhat.com> writes:
>>>
>>> > On 21/06/2016:05:43:29 AM, Atsushi Kumagai wrote:
>>> >> Hello Vitaly,
>>> >>
>>> >> >_count member was renamed to _refcount in linux commit 0139aa7b7fa12
>>> >> >("mm: rename _count, field of the struct page, to _refcount") and this
>>> >> >broke makedumpfile. The reason for making the change was to find all users
>>> >> >accessing it directly and not through the recommended API. I tried
>>> >> >suggesting to revert the change but failed, I see no other choice than to
>>> >> >start supporting both _count and _refcount in makedumpfile.
>>> >> >
>>> >> >Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> >> >---
>>> >> >Changes since 'v1':
>>> >> >- Make '_refcount' the default [Atsushi Kumagai]
>>> >
>>> > Sorry, I missed this conversation earlier.
>>> >
>>> >>
>>> >> Good fix, I'll merge this into v1.6.1.
>>> >>
>>> >> Thanks,
>>> >> Atsushi Kumagai
>>> >>
>>> >> >---
>>> >> > makedumpfile.c | 26 +++++++++++++++++++++-----
>>> >> > makedumpfile.h |  3 ++-
>>> >> > 2 files changed, 23 insertions(+), 6 deletions(-)
>>> >> >
>>> >> >diff --git a/makedumpfile.c b/makedumpfile.c
>>> >> >index 853b999..fd884d3 100644
>>> >> >--- a/makedumpfile.c
>>> >> >+++ b/makedumpfile.c
>>> >> >@@ -1579,7 +1579,14 @@ get_structure_info(void)
>>> >> > 	 */
>>> >> > 	SIZE_INIT(page, "page");
>>> >> > 	OFFSET_INIT(page.flags, "page", "flags");
>>> >> >-	OFFSET_INIT(page._count, "page", "_count");
>>> >> >+	OFFSET_INIT(page._refcount, "page", "_refcount");
>>> >> >+	if (OFFSET(page._refcount) == NOT_FOUND_STRUCTURE) {
>>> >> >+		info->flag_use_count = TRUE;
>>> >> >+		OFFSET_INIT(page._refcount, "page", "_count");
>>> >> >+	} else {
>>> >> >+		info->flag_use_count = FALSE;
>>> >
>>> > Probably we could have avoided this flag and could have solved it same way as we
>>> > have solved for other such kernel changes, like that of "module.module_core".
>>> > Infact, we do not need to add "_refcount" in makedumpfile's page struct.
>>> >
>>>
>>> Yes, the flag is only needed to do the write. Why do you think we don't
>>> need it?
>>
>> IMHO, even if we write with "page._count", we would be able to get correct
>> value in next read, because we prefer reading with "page._count" over
>> "page._refcount". I think "crash utility" also gives priority for reading with
>> _count, so things should work without any issue.
>
>While things will probably work now while everyone still remembers the
>old "_count" name it may happen that some tool will drop this support in
>future and this will lead to an awkward situation when everythin works
>with /proc/vmcore but doesn't work with makedumpfile's output. Said that
>I think it makes sense for makedumpfile to be precise and write what we
>read. IMO, of course, I'm not a regular makedumpfile contributor.

Yeah, I think it would be better to write down the correct current name
even if the code gets a bit more complicated, thus I accepted the Vitaly's patch.


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
