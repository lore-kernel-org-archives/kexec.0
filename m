Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTj4w-0003pF-2W
 for kexec@lists.infradead.org; Wed, 29 Apr 2020 09:32:31 +0000
Subject: Re: [PATCH] makedumpfile: cope with not-present mem section
References: <1579487124-28426-1-git-send-email-piliu@redhat.com>
 <2AA47CAB-ED13-4A0A-9288-063832158203@redhat.com>
 <20200120085919.GB16539@MiWiFi-R3L-srv>
 <44958c3d-c861-8eb0-5713-50c36c7cfc6e@redhat.com>
 <TY2PR01MB5210FAB04501E6C59AAB2B06DD0F0@TY2PR01MB5210.jpnprd01.prod.outlook.com>
 <20200127170447.GA4080@calabresa> <20200127180627.GB4080@calabresa>
 <TY2PR01MB521005B2E72D78C4561C0562DD0A0@TY2PR01MB5210.jpnprd01.prod.outlook.com>
 <20200128193302.GC4080@calabresa>
From: piliu <piliu@redhat.com>
Message-ID: <769ddb8a-c845-04a6-0064-d674bbd04ae3@redhat.com>
Date: Wed, 29 Apr 2020 17:32:11 +0800
MIME-Version: 1.0
In-Reply-To: <20200128193302.GC4080@calabresa>
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
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>

Hi Kazu and Cascardo,

I encounter a weird problem when running makedumpfile on a s390 machine.

Our production kernel uses extreme sparse memory model, and has the
following:

in mm/sparse.c

#ifdef CONFIG_SPARSEMEM_EXTREME
struct mem_section **mem_section;
#else
struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
        ____cacheline_internodealigned_in_smp;
#endif

So in makedumpfile.c, get_mem_section(), it got a failed result when the
first call site to validate_mem_section(), then it should success at the
second call site to validate_mem_section(), which is inside if
(is_sparsemem_extreme()) condition.

But the actual result is not like expected.

After introducing
commit e113f1c974c820f9633dc0073eda525d7575f365    [PATCH] cope with
not-present mem section

I got two successful calls to validate_mem_section(), and finally failed
at the condition
		ret = symbol_valid ^ pointer_valid;
		if (!ret) {
			ERRMSG("Could not validate mem_section.\n");
		}


Do you have any idea?

Thanks,
Pingfan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
