Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VzDAy-0000fs-Fy
 for kexec@lists.infradead.org; Fri, 03 Jan 2014 22:25:09 +0000
Message-ID: <52C7389C.6000902@zytor.com>
Date: Fri, 03 Jan 2014 14:24:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH tip/efi-kexec] x86: setup.c build fix
References: <20140103035648.GA5291@darkstar.nay.redhat.com>
 <20140103144044.GD2618@console-pimps.org>
In-Reply-To: <20140103144044.GD2618@console-pimps.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matt Fleming <matt@console-pimps.org>, Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org

On 01/03/2014 06:40 AM, Matt Fleming wrote:
> On Fri, 03 Jan, at 11:56:49AM, Dave Young wrote:
>> In case without CONFIG_EFI, there will be below build error:
>>    arch/x86/built-in.o: In function `setup_arch':
>>>> (.init.text+0x9dc): undefined reference to `parse_efi_setup'
>>
>> Thus fix it by adding blank inline function in asm/efi.h
>> Also remove an unused declaration for variable efi_data_len.
>>
>> Signed-off-by: Dave Young <dyoung@redhat.com>
>> ---
>>  arch/x86/include/asm/efi.h |    5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Thanks Dave. I picked up both patches.
> 

Something I should be pulling?

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
