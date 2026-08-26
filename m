Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5939C61DBD
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8J4DRYWG08OsFnKUOMRGMGmz+rKwmpDGtxgc6hW2bX8=; b=S1/AG/XNMYprzKm3cX4wypZ+I3
	xbn+W3/9FKoiCEsoeZZcy12hCvmFICCZMZvc2b+pS5oE80FPIaREWSY5q3PldxAan3jn/9V0fvEX8
	O/ZzdzQ3x/oUu8ogm97bMghYr7yMrn3TTQzNHhZUpzJmbowZuMUKR7hV2JsO7rMRDnVftouEuXna9
	I+PYa59fxUHDuOFzR8oyihr5FQTNaGLPjmlJLIKK8GoxOEkYxmBp10j9IcpFk7EpvFxfEShIfv52B
	ZYK53sZ/TpG9QCcxQ49YXwhoV0WSB+Ky6RsoZeGqr9S1jDDapG/Ahb3TaRlWBW+rffz4335NxrJ0A
	nwqYmRKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzDkw-00000002W3W-3Yfh;
	Wed, 26 Aug 2026 13:33:30 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzDkq-00000002W2t-23Ox
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 13:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787751204; x=1819287204;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8J4DRYWG08OsFnKUOMRGMGmz+rKwmpDGtxgc6hW2bX8=;
  b=IgYkmzh3r0nmEmu3ntaOy4yV5bqeyR0Ji6667V8ZUl4B2CvsJADjaoX5
   KS4y1pGdUKzHnygmJylTvZw/EhmXMujyq4XNQ+jgMnWWA9rTnDhAUxSXb
   vMf7f9dS1qL1i6IyMVwde5c+j/oSJ14/Y5UFqzuXjdRmGh+P6TznHCUkk
   AFho9BOl7yVi++LFGMmkVk1sPvXzT9cFkO2UNgKvqwhGt86Exoq+lIHDu
   K7LAgjD33+60DEhb1dKPIclDs/+3c66H1qoY5kWGw+a5N1jZSdDamrx57
   o7zRFc/ZiMie6761wj6iSEDPTQi3m6/OjiyBankbXSsTz/srU+H3Uudht
   Q==;
X-CSE-ConnectionGUID: BSliPz9WRIKClw+vjjxHgA==
X-CSE-MsgGUID: n2TgSA8oQvuLCFnepOckIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="90742691"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="90742691"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:33:23 -0700
X-CSE-ConnectionGUID: fi5T9AQgRHK+SFB76qGiag==
X-CSE-MsgGUID: ySqgx6cOTpOE0EdGdDI7Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="305804799"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.37]) ([10.125.109.37])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:33:24 -0700
Message-ID: <33cf028a-58c7-4ffd-af80-d689a67684c7@intel.com>
Date: Wed, 26 Aug 2026 06:33:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS,
 not CONFIG_NR_CPUS_DEFAULT
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
 baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
 pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
 hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, ruanjinjie@huawei.com,
 include@grrlz.net, linux-kernel@vger.kernel.org
References: <20260826073527.21487-1-ionut.nechita@windriver.com>
 <20260826073527.21487-2-ionut.nechita@windriver.com>
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
In-Reply-To: <20260826073527.21487-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_063324_584491_8A55ED0B 
X-CRM114-Status: UNSURE (   4.46  )
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

On 8/26/26 00:35, Ionut Nechita (Wind River) wrote:
> Assisted-by: LLM

"LLM" went a little wild on the changelogs here. Shouldn't this just be
something like:

NR_CPUS_DEFAULT is *purely* a Kconfig thing. Its entire purpose in life
is to start NR_CPUS at a sane value. There is precisely one (buggy)
reference to it outside of Kconfig in the whole kernel: the x86 crash code.

That code will undersize a reservation if NR_CPUS exceeds
NR_CPUS_DEFAULT. This causes kexec_load() silently truncate the
elfcorehdr, which surfaces later as a bad or unusable dump.

Size the elfcorehdr reservation with NR_CPUS instead.

---

Does it need more than that?

