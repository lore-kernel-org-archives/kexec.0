Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58858C3ABAA
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rRMjo90hDshBuX2Qfp/xtCOZ0UVS9PQPBAg6H6XdXQ=; b=c8fM6RGfSVEGGitGYKhok6OZkJ
	5U+/wxnQfGwnEE9T9IqbHgGd4I9176VCYZHCrUXZMkObjLQtht6C216NzYQhSTbqG85Y+65dz3Kc8
	tE3SFcWOsFgaCzX42OIwRZTLTlD/XsXDLvgiI0QM7tDWvm3RV2zKpV8g429sVOgg2pNMLDDDgOQZc
	z5ixrpWs7hygMdXghcBCLszrZF8AFlsziMIDzXsQjOMQKrLapgJhA5zl23sFQaj2APYv5GhsRfjxE
	jZGNknvmDps+aTKcurNuhSDeengXMv0sP/qC3LCWvvWjcOqHYeHXsjCA4nPKL/FvfqbqTrLKmBtF4
	RKpvBlvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAvIo-00000002maa-40YR;
	Fri, 02 May 2025 18:40:02 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAvHx-00000002mOK-03ei;
	Fri, 02 May 2025 18:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746211149; x=1777747149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k4bpnd3rel4lDav3D9jMnc5FYe9j0M+IePk2yRuFE1w=;
  b=U+zpbrLLARoIPJlr/A5P0uVL7UsN4KB5bBzULMihb9fle7RnjLEir6B/
   Mw3hD/IggAkwUoMdhZeE2G5wqoy8tYAfOzwBwWQq/czBTdk5lpbxVT/Ky
   cMYmYoviRAZacx6GiWoF/5IFu52Cn8uNMdK4NjIOHQRu/STPZxlMAWgz8
   eqQ4ovwOIKrR9DuO9unlRy/EUub+k9Uv0Aik3zkiGf1vyVihUAUtttbu3
   jH7KzPaC7ZOuPi8QI2kU0NdtQfTHODM3HfPiDqXu8TeE984fhs4NhQPIZ
   E62Y7oNCQw+0znzXA2J3auWFzkPpK0EW0CpqfoKzvF8J3VsAueZTyOYnh
   Q==;
X-CSE-ConnectionGUID: BQ8lLJXCTwW3o+dv4pNkLg==
X-CSE-MsgGUID: C7QMCLsVSw299XkqysciRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="35518227"
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="35518227"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 11:39:06 -0700
X-CSE-ConnectionGUID: /0mAd8ECTXqelpKpeQuAfA==
X-CSE-MsgGUID: 6eMiZhjuRfSko/i4n3d/bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="134663527"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.153]) ([10.124.220.153])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 11:39:04 -0700
Message-ID: <9dcf8bd9-f4c3-4c7d-a717-ff3eb95f12b9@intel.com>
Date: Fri, 2 May 2025 11:39:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/18] x86/kexec: add support for passing kexec
 handover (KHO) data
To: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
 devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com,
 graf@amazon.com, hpa@zytor.com, jgowans@amazon.com,
 kexec@lists.infradead.org, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org,
 ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
 saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de,
 thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
References: <20250501225425.635167-1-changyuanl@google.com>
 <20250501225425.635167-13-changyuanl@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20250501225425.635167-13-changyuanl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_113909_068607_635CA8CB 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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

On 5/1/25 15:54, Changyuan Lyu wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> kexec handover (KHO) creates a metadata that the kernels pass between each
> other during kexec. This metadata is stored in memory and kexec image
> contains a (physical) pointer to that memory.
> 
> In addition, KHO keeps "scratch regions" available for kexec: physically
> contiguous memory regions that are guaranteed to not have any memory that
> KHO would preserve. The new kernel bootstraps itself using the scratch
> regions and sets all handed over memory as in use. When subsystems that
> support KHO initialize, they introspect the KHO metadata, restore preserved
> memory regions, and retrieve their state stored in the preserved memory.
> 
> Enlighten x86 kexec-file and boot path about the KHO metadata and make sure
> it gets passed along to the next kernel.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

