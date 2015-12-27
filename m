Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t4621.austin.hp.com ([15.73.212.80])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aCzFV-0008Bd-Gp
 for kexec@lists.infradead.org; Sun, 27 Dec 2015 00:31:50 +0000
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc() for
 iomem search
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226103804.GB21988@pd.tnic>
From: Toshi Kani <toshi.kani@hpe.com>
Message-ID: <567F315B.8080005@hpe.com>
Date: Sat, 26 Dec 2015 17:31:23 -0700
MIME-Version: 1.0
In-Reply-To: <20151226103804.GB21988@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-nvdimm@lists.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>

+ cc: kexec list

On 12/26/2015 3:38 AM, Borislav Petkov wrote:
> On Fri, Dec 25, 2015 at 03:09:23PM -0700, Toshi Kani wrote:
>> Change to call walk_iomem_res_desc() for searching resource entries
>> with the following names:
>>   "ACPI Tables"
>>   "ACPI Non-volatile Storage"
>>   "Persistent Memory (legacy)"
>>   "Crash kernel"
>>
>> Note, the caller of walk_iomem_res() with "GART" is left unchanged
>> because this entry may be initialized by out-of-tree drivers, which
>> do not have 'desc' set to IORES_DESC_GART.
>
> There's this out-of-tree bogus argument again. :\
>
> Why do we care about out-of-tree drivers?
>
> You can just as well fix the "GART" case too and kill walk_iomem_res()
> altogether...

Right, but I do not see any "GART" case in the upstream code, so I 
cannot change it...

Thanks,
-Toshi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
