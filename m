Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] Documentation/vmcoreinfo: Add documentation for
 'KERNELPACMASK'
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <1587968702-19996-2-git-send-email-amit.kachhap@arm.com>
 <20200504173440.GE1833@willie-the-truck>
From: Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <c5b441e9-8dd4-d2e7-20bb-b934b68dad9a@arm.com>
Date: Wed, 6 May 2020 17:37:10 +0530
MIME-Version: 1.0
In-Reply-To: <20200504173440.GE1833@willie-the-truck>
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
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Hi,

On 5/4/20 11:04 PM, Will Deacon wrote:
> On Mon, Apr 27, 2020 at 11:55:02AM +0530, Amit Daniel Kachhap wrote:
>> Add documentation for KERNELPACMASK variable being added to the vmcoreinfo.
>>
>> It indicates the PAC bits mask information of signed kernel pointers if
>> Armv8.3-A Pointer Authentication feature is present.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>>   Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> index 007a6b8..5cc3ee6 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -393,6 +393,12 @@ KERNELOFFSET
>>   The kernel randomization offset. Used to compute the page offset. If
>>   KASLR is disabled, this value is zero.
>>   
>> +KERNELPACMASK
>> +-------------
>> +
>> +Indicates the PAC bits mask information if Pointer Authentication is
>> +enabled and address authentication feature is present.
> 
> This is a bit cryptic. How about:
> 
>    The mask to extract the Pointer Authentication Code from a kernel virtual
>    address.

Ok sure. I will update like this in the v3 version.

Cheers,
Amit Daniel
> 
> Will
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
