Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com
 ([104.47.38.72] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLBKK-00018b-JD
 for kexec@lists.infradead.org; Wed, 14 Jun 2017 16:39:30 +0000
Subject: Re: [PATCH v6 23/34] x86, realmode: Decrypt trampoline area if memory
 encryption is active
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191709.28645.69034.stgit@tlendack-t1.amdoffice.net>
 <20170614162416.ksa54esy5ql7sjgz@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <dffd4702-9598-40ef-c9ad-ef970df13e32@amd.com>
Date: Wed, 14 Jun 2017 11:38:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170614162416.ksa54esy5ql7sjgz@pd.tnic>
Content-Language: en-US
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 6/14/2017 11:24 AM, Borislav Petkov wrote:
> On Wed, Jun 07, 2017 at 02:17:09PM -0500, Tom Lendacky wrote:
>> When Secure Memory Encryption is enabled, the trampoline area must not
>> be encrypted. A CPU running in real mode will not be able to decrypt
>> memory that has been encrypted because it will not be able to use addresses
>> with the memory encryption mask.
>>
>> A recent change that added a new system_state value exposed a warning
>> issued by early_ioreamp() when the system_state was not SYSTEM_BOOTING.
>> At the stage where the trampoline area is decrypted, the system_state is
>> now SYSTEM_SCHEDULING. The check was changed to issue a warning if the
>> system_state is greater than or equal to SYSTEM_RUNNING.
> 
> This piece along with the hunk touching system_state absolutely needs to
> be a separate patch as it is unrelated.

Yup, will do.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
