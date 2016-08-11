Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x243.google.com ([2607:f8b0:400e:c03::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXkZz-0000ET-KJ
 for kexec@lists.infradead.org; Thu, 11 Aug 2016 07:39:07 +0000
Received: by mail-pa0-x243.google.com with SMTP id hh10so4294387pac.1
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 00:38:42 -0700 (PDT)
Subject: Re: [PATCH 0/7] ima: carry the measurement list across kexec
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <91fa2f95-4d70-a056-d599-01cb3bbe6771@gmail.com>
 <1470746204.2881.101.camel@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <46d115a8-de96-1e9f-9d08-b0e9b6cca93a@gmail.com>
Date: Thu, 11 Aug 2016 17:38:35 +1000
MIME-Version: 1.0
In-Reply-To: <1470746204.2881.101.camel@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org



On 09/08/16 22:36, Mimi Zohar wrote:
> On Tue, 2016-08-09 at 15:19 +1000, Balbir Singh wrote:
>>
>> On 04/08/16 22:24, Mimi Zohar wrote:
>>> The TPM PCRs are only reset on a hard reboot.  In order to validate a
>>> TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
>>> of the running kernel must be saved and then restored on the subsequent
>>> boot.
>>>
>>> The existing securityfs binary_runtime_measurements file conveniently
>>> provides a serialized format of the IMA measurement list. This patch
>>> set serializes the measurement list in this format and restores it.
>>>
>>> This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
>>> hand-over for the next kernel" patch set* for actually carrying the
>>> serialized measurement list across the kexec.
>>>
>>> Mimi
>>>
>>
>> Hi, Mimi
>>
>> I am trying to convince myself of the security of the solution. I asked
>> Thiago as well, but may be I am be lagging behind in understanding.
>>
>> We trust the kernel to hand over PCR values of the old kernel (which
>> cannot be validated) to the IMA subsystem in the new kernel for storage.
>> I guess the idea is for ima_add_boot_aggregate to do the right thing?
>> How do we validate what the old kernel is giving us? Why do we care for
>> the old measurement list? Is it still of significance in the new kernel?
>>
> 
> Hi Balbir,
> 
> To validate the hardware TPM PCR values requires walking the measurement
> list simulating the TPM extend operation.  The resulting values should
> match the hardware TPM PCRs.
> 
> In the case of a soft reboot, the TPM PCRs are not reset to 0, so all
> the measurements of the running system, including those from previous
> soft reboots, need to be included in the measurement list.   Without
> these measurements, the simulated PCR values will not match the hardware
> TPM PCR values.  Thus the need for this patch set.
> 
> Measurements can not be added/removed/changed in the measurement list
> without it being detectable.
> 

Thanks Mimi

I think that makes sense

So effectively we do

first kernel boot -> <measurements match PCR and measurements are saved>
second kernel boot -> <new PCR = first save measurements + new measurements>

and so on

Balbir Singh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
