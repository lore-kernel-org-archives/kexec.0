Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F38CA0FED
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 01:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VCovnQiKBqc8KwjIgSafo1ECvn4VKWgvcShqCm4XuY4=; b=nnsVN9TxyCpJjov1lQwICmUPon
	fqsL3w8RL/8icdQem2iHSl/xp6xeBaC5UDkY4yOoaGLPSaYcIKk9tjChhEdrQl4Z2ZQ/P9+GjKg4M
	DVRlwNwus5i8Z4TD59lq0r5j6kuEXWFYVGW7Z146OqRW6H0wH6w77vue7ufNocQWc3begGSWxUZDU
	ygmbFyRwrRzVnAYVaNtD2sNWysrOfUY8AktpPN2PUJ96Fr58qIHyq0jTUb3FzHaeSSQ8T0hj0Z2ic
	L7zVsTJEQSbZ+fhE3kWMwLANgCDd4MUeZdPcmWpJPg3FDF3/6wN1vblWLz94YN6J6vIsDkp9aJwGr
	nadhIBUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw9Ce-0000000BHb4-3Xbs;
	Wed, 10 Sep 2025 01:00:52 +0000
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw9Cc-0000000BHYY-0xlp;
	Wed, 10 Sep 2025 01:00:50 +0000
Message-ID: <4e230009-ed70-4260-ba61-170ddab17a80@infradead.org>
Date: Tue, 9 Sep 2025 18:00:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] Documentation, kstate: Add KSTATE documentation
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 James Gowans <jgowans@amazon.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
 William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-8-arbn@yandex-team.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250909201446.13138-8-arbn@yandex-team.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 9/9/25 1:14 PM, Andrey Ryabinin wrote:
> Add KSTATE doc. Describe 'struct kstate_description' and information
> about versioning fields.
> 
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> ---
>  Documentation/core-api/index.rst  |   1 +
>  Documentation/core-api/kstate.rst | 117 ++++++++++++++++++++++++++++++
>  MAINTAINERS                       |   1 +
>  3 files changed, 119 insertions(+)
>  create mode 100644 Documentation/core-api/kstate.rst
> 

> diff --git a/Documentation/core-api/kstate.rst b/Documentation/core-api/kstate.rst
> new file mode 100644
> index 000000000000..981ba162109c
> --- /dev/null
> +++ b/Documentation/core-api/kstate.rst
> @@ -0,0 +1,117 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +KSTATE: Kernel state preservation framework
> +===========================================
> +
> +KSTATE (kernel state) is framework to migrate some part of the internal
> +kernel state (device driver, memory, etc) from one kernel to another across
> +kexec reboot.
> +
> +kstate_description
> +------------------
> +
> +Most kernel's state is in structs and structs could be described by

   Most kernel state

> +kstate_description. E.g. <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> +
> +struct kstate_test_data {
> +	int i;
> +	unsigned long *p_ulong;
> +	char s[10];
> +	struct folio *folio;
> +};
> +
> +struct kstate_description test_state = {
> +	.name = "test",
> +	.version_id = 1,
> +	.id = KSTATE_TEST_ID,
> +	.fields = (const struct kstate_field[]) {
> +		KSTATE_BASE_TYPE(s, struct kstate_test_data, char [10]),
> +		KSTATE_POINTER(p_ulong, struct kstate_test_data),
> +		KSTATE_FOLIO(folio, struct kstate_test_data),
> +		KSTATE_END_OF_LIST()
> +	},
> +};
> +
> +Changing data structures
> +------------------------
> +
> +KSTATE saves/restores structs as a series of fields. When the kernel structs
> +are changed we may need to change the state to store more/different information.
> +
> +Versions
> +--------
> +
> +Version numbers are intended for major incompatible changes, that are not

no comma
Drop "incompatible" since that is implied in the rest of the sentence.

> +backward compatible.
> +
> +Each version is associated with a series of fields saved. The state is always
> +saved as the newest version specified by ->version_id.
> +But loading state sometimes is able to load state from an older version.
> +
> +There are two version fields:
> +
> +    - version_id: the maximum version_id supported by kstate_description.
> +    - min_version_id: the minimum version_id that given kstate_description is able to understand.
> +
> +KSTATE is able to read versions from minimum_version_id to version_id.
> +
> +There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.
> +
> +	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
> +
> +only loads that field for versions 2 and newer.
> +
> +Saving state will always create a section with the ‘version_id’ value and thus can’t
> +be loaded by any older kernel.
> +
> +Removing field
> +--------------
> +If field is no longer needed it could be marked deprecated using

   If a field

> +KSTATE_*_DEPRECATED macro and bumping ->version_id of kstate_description:
> +
> +	KSTATE_BASE_TYPE_DEPRECATED(k, u16, 1),
> +
> +The last parameter of the macro is the last version number that have this field.

                                                                   has

> +Old kernel will save such field, but new kernel will skip it on load. Also

   An old kernel                        a new kernel

> +the new kernel will not save such field (as there is nothing to save).
> +Such change is not backward compatible.
> +
> +Adding new field
> +----------------
> +
> +Addition of new field can be done as version dependent field by using _V form of

            of a new field           as a version-dependent field by using the _V form of


> +KSTATE_ macro:
> +	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
> +
> +This indicates that 'test_state' only from version 2 and above have field '->i'.
> +If new kernel sees incoming 'test_state' of version 1 it will skip restoring '->i'

   If a new kernel
or
   If the new kernel

> +as nothing was saved. This is not backward compatible, as old kernel doesn't

                                                          as an old kernel doesn't

> +understand the new V2 'test_state'.
> +
> +Subsections
> +-----------
> +Another option is adding subsection to kstate_description. A subsection is

                     adding a subsection

> +additional kstate_description which linked to the main one:

   an additional                 which is linked to the main one:

> +
> +struct kstate_description test_state_v2 = {
> +	.name = "test_v2",
> +	.id = KSTATE_TEST_ID_V2,
> +	.fields = (const struct kstate_field[]) {
> +		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
> +		KSTATE_END_OF_LIST()
> +	},
> +};
> +
> +struct kstate_description test_state = {
> +	......
> +	.subsections = (const struct kstate_description *[]){
> +		&test_state_v2,
> +		NULL
> +	},
> +};
> +
> +
> +Subsection must have a unique ->id. If the receiving side finds a subsection

   A subsection

> +with unknown id it will be ignored. This make subsections suitable for backward
> +compatible changes (migrate from N+1 to N kernel) assuming old kernel is ok without

                                                     assuming the old kernel

> +information in subsection.

               in the subsection.

-- 
~Randy


