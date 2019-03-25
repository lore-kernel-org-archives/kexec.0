Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr680045.outbound.protection.outlook.com
 ([40.107.68.45] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8TEa-0005uT-NQ
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 17:18:06 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Date: Mon, 25 Mar 2019 17:17:55 +0000
Message-ID: <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
In-Reply-To: <20190325063742.GA12016@zn.tnic>
Content-Language: en-US
Content-ID: <20558C964D194A419E3230BDC7DFEF99@namprd12.prod.outlook.com>
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
To: Borislav Petkov <bp@alien8.de>, lijiang <lijiang@redhat.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Hi Boris,


On 3/25/19 1:37 AM, Borislav Petkov wrote:
> On Mon, Mar 25, 2019 at 09:58:07AM +0800, lijiang wrote:
>> For the SEV virtual machine, it maps the kexec memroy area as
>> encrypted, so, no need to invoke this function to change anything.
> 
> Look at the code:
> 
> set_memory_decrypted->__set_memory_enc_dec
> 
> It already *does* invoke this function.
> 

By default all the memory regions are mapped encrypted. The
set_memory_{encrypt,decrypt}() is a generic function which can be
called explicitly to clear/set the encryption mask from the existing
memory mapping. The mem_encrypt_active() returns true if either SEV or 
SME is active. So the __set_memory_enc_dec() uses the
memory_encrypt_active() check to ensure that the function is no-op when
SME/SEV are not active.

Currently, the arch_kexec_post_alloc_pages() unconditionally clear the
encryption mask from the kexec area. In case of SEV, we should not clear
the encryption mask.



>>> 	if (!mem_encrypt_active())
>>>
>>> and heads will spin from all the checking of memory encryption aspects.
>>>
>>> So this would need a rework so that there are no multiple confusing
>>> checks.
>>
>> About the three functions, here i copied their comment from the arch/x86/mm/mem_encrypt.c
>> Please refer to it.
> 
> I know that comment - I have asked for it. Now you go and look at the
> code again with your patch applied.
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
