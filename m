Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9CCC43334
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6jxz1A+YUrTC2pQ8hjUEq8u8Z4zgzd1Ckln1vx7jA7M=; b=AzFRSr65fCp44vcO6l2iLw02Ho
	uN6xmpE3xH/iwQm+rgFl56Fl1zIM5Wgt60qbFWAW/jbV5CALmyt+aJpkQfwB/phnfu7OHo/v8Tlwt
	VsW+drzaZhhSSkCQySqblmroJ4GqOUQvi4jmKYqMNkyHszHe3F9NHKfdbTEQSNlYmYB3rweCPYOU0
	Wehdt1bsDvp1xh+wmW/3Tt3ZevS6qkP3iJyZ6kcIe3I67gfnII2sjbg2yktQ6+w0LGcIWfThuG4v6
	xTutk7qAnU/odOh3Bqg/zkUmbKscImWefSsTdKpGA4Vpq0t5aBvx/E15i9i8w6OLPt/EUvMLqejK2
	UfkV09+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1apP-00GViE-3e; Wed, 15 Jun 2022 21:45:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1apL-00GVg0-Kz
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 21:45:30 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLQN2Q029281;
	Wed, 15 Jun 2022 21:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HxQqF5AZNyyBkcQ54ngNpw+Ul/ByxSDpXkpEm8RldsQ=;
 b=ONstXM/4eVnOTGO30A/GI36wBTr77Zh8QQoLJhR7Kbjvj3cFwlVIh9A++3Fn9yxLxnkA
 6PBlAOEwD+1EWVR93ieXRPbgf1pkbV87lDTkzGK0ijroUbx7S5hUDSIj4FrvzFbVE9s7
 LtcAwrJXrkksbvDO/VzYIpQ2NNoeJSYh0NptiZwho/KNjGqHTaqX45stWN7qpNw9OcCR
 Ie9LwnnLCyJBJ8N4PcUv3TQklcjgrNG+pbnqm/ybarrFML4M1q1/sDIKS9A4KnsUQ/d3
 wwhxG6srJQ1w2Muhbkgxx1EF6ubNQQqn3/KJdS5Aa4bKRj9nOIFhwpQR87ANee4j5eMy fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqbn2ct61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jun 2022 21:45:19 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25FLjJQx016477;
	Wed, 15 Jun 2022 21:45:19 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqbn2ct5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jun 2022 21:45:19 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25FLKtA3025401;
	Wed, 15 Jun 2022 21:45:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by ppma03wdc.us.ibm.com with ESMTP id 3gmjp9nrux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jun 2022 21:45:18 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25FLjHTE9831082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jun 2022 21:45:17 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C521DAE05C;
	Wed, 15 Jun 2022 21:45:17 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B475AE05F;
	Wed, 15 Jun 2022 21:45:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jun 2022 21:45:17 +0000 (GMT)
Message-ID: <08cccbf2-ac65-bd73-d51f-8ea52af2e975@linux.ibm.com>
Date: Wed, 15 Jun 2022 17:45:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] tpm/kexec: Duplicate TPM measurement log in of-tree
 for kexec
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com,
        Frank Rowand <frowand.list@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <20220614161258.1741427-1-stefanb@linux.ibm.com>
 <20220614161258.1741427-3-stefanb@linux.ibm.com>
 <CAL_JsqJG4MJHeu+7Ar0jWi-W6P01_EFtwiz56m_vtVy39uMtiw@mail.gmail.com>
 <af78f4b6-4cfb-5ea6-fdc9-dfcb73f4bc8c@linux.ibm.com>
 <20220615201453.GA1525994-robh@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220615201453.GA1525994-robh@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vWZ7LXPZfaU4xiCG9nOWskCpHAQ661-V
X-Proofpoint-ORIG-GUID: E6u1F21zwS4lKSlhzff-uF4R6O-Wn1MI
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_16,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_144528_099921_C2E10F23 
X-CRM114-Status: GOOD (  66.82  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 6/15/22 16:14, Rob Herring wrote:
> On Wed, Jun 15, 2022 at 09:08:04AM -0400, Stefan Berger wrote:
>>
>>
>> On 6/14/22 13:48, Rob Herring wrote:
>>> (),On Tue, Jun 14, 2022 at 10:13 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>> The memory area of the TPM measurement log is currently not properly
>>>> duplicated for carrying it across kexec when an Open Firmware
>>>> Devicetree is used. Therefore, the contents of the log get corrupted.
>>>> Fix this for the kexec_file_load() syscall by allocating a buffer and
>>>> copying the contents of the existing log into it. The new buffer is
>>>> preserved across the kexec and a pointer to it is available when the new
>>>> kernel is started. To achieve this, store the allocated buffer's address
>>>> in the flattened device tree (fdt) under the name linux,tpm-kexec-buffer
>>>> and search for this entry early in the kernel startup before the TPM
>>>> subsystem starts up. Adjust the pointer in the of-tree stored under
>>>> linux,sml-base to point to this buffer holding the preserved log. The
>>>> TPM driver can then read the base address from this entry when making
>>>> the log available.
>>>
>>> This series really needs a wider Cc list of folks that worry about
>>> TPMs and kexec.
>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>>> ---
>>>>    drivers/of/device.c       |  24 +++++
>>>>    drivers/of/kexec.c        | 190 +++++++++++++++++++++++++++++++++++++-
>>>>    include/linux/kexec.h     |   6 ++
>>>>    include/linux/of.h        |   5 +
>>>>    include/linux/of_device.h |   3 +
>>>>    kernel/kexec_file.c       |   6 ++
>>>>    6 files changed, 233 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>>> index 874f031442dc..0cbd47b1cabc 100644
>>>> --- a/drivers/of/device.c
>>>> +++ b/drivers/of/device.c
>>>> @@ -382,3 +382,27 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
>>>>           return 0;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
>>>> +
>>>> +int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size)
>>>
>>> of/device.c is for functions that work on a struct device. This is not
>>> the case here.
>>
>> Can I put it into platform.c?
> 
> That's for struct platform_device things.
> Should I create a new file then?

>> I should have probably mentioned it but this function here is a copy of code
>> from tpm_read_log_of() from here: https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/eventlog/of.c#L38
>>
>> 3/3 refactors the code in tpm/eventlog/of.c to make use of this new function
>> then to avoid code duplication. Therefore, this code here is more general
>> than necessary at this point. Maybe I should do the move in a patch of its
>> own?
> 
> Maybe you should leave that function there and call it?

The function would only be callable if TPM subsystem was enabled. That 
doesn't sound right to make kexec depend on the TPM subsystem.

I could just implement a less generic function that only handles the 
vTPM case then and not target this function to be called from the TPM 
subsystem via the refactoring in 3/3.

> 
> Generally, subsystem specific things go into the subsystems. However,
> there's a few special cases like kexec now. That was added primarily to
> avoid per arch duplication.
> 
> I've never looked at the TPM code, so sorry, I don't have more specific
> suggestions.
> 
>>>> +{
>>>> +       const u32 *sizep;
>>>> +       const u64 *basep;
>>>> +
>>>> +       sizep = of_get_property(np, "linux,sml-size", NULL);
>>>> +       basep = of_get_property(np, "linux,sml-base", NULL);
>>>
>>> Any new properties need a schema. For chosen, that's located here[1].
>>> The more common pattern for similar properties is <base size>.
>>>
>>> Don't use of_get_property(), but the typed functions instead.
>>
>> I think this was done due to the little endian and big endian distinction
>> below.
> 
> 
> Right.
> 
>>>> +       if (sizep == NULL && basep == NULL)
>>>> +               return -ENODEV;
>>>> +       if (sizep == NULL || basep == NULL)
>>>> +               return -EIO;
>>>
>>> Do we really need the error distinction?
>>
>> As I mentioned, this code is a copy from the TPM subsystem. There it does
>> make a distinction because similar functions for acpi and efi make a
>> distinction as well although this particular function's return code doesn't
>> matter in the end.
>>
>> The code I am referring to is this here:
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/eventlog/common.c#L85
>>
>>>
>>>> +
>>>> +       if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
>>>> +           of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
>>>> +               *size = be32_to_cpup((__force __be32 *)sizep);
>>>> +               *base = be64_to_cpup((__force __be64 *)basep);
>>>> +       } else {
>>>> +               *size = *sizep;
>>>> +               *base = *basep;
>>>
>>> What? Some platforms aren't properly encoded? Fix the firmware.
>>
>> It's been like this for years...
> 
> Great! :(
> 
> I'm confused how IBM needs this? Only a LE machine with LE DT encoding
> would need this. With Power being historically BE and only recently
> (though I guess that's a few years now) supporting LE, how did the DT
> encoding become LE for this yet not for everything else in DT?
> 


For some reason the TPM log of a hardware TPM I believe is written in 
little endian. I am not aware of the history of it.

> [...]
> 
> 
>>>> +/**
>>>> + * tpm_post_kexec - Make stored TPM log buffer available in of-tree
>>>> + */
>>>> +static int __init tpm_post_kexec(void)
>>>> +{
>>>> +       struct property *newprop;
>>>> +       struct device_node *np;
>>>> +       void *phyaddr;
>>>> +       size_t size;
>>>> +       u32 oflogsize;
>>>> +       u64 unused;
>>>> +       int ret;
>>>> +
>>>> +       ret = tpm_get_kexec_buffer(&phyaddr, &size);
>>>> +       if (ret)
>>>> +               return 0;
>>>> +
>>>> +       /*
>>>> +        * If any one of the following steps fails then the next kexec will
>>>> +        * cause issues due to linux,sml-base pointing to a stale buffer.
>>>> +        */
>>>> +       np = of_find_node_by_name(NULL, "vtpm");
>>>
>>> This seems pretty IBM specific.
>>
>> Yes, it is and I am not sure what to do about it. Should I cover parts of
>> the function with a #ifdef CONFIG_PPC_PSERIES ?
> 
> #ifdef's aren't great. IS_ENABLED() is a bit better, but really put
> implementation specific things in implementation specific code.
> 
> Perhaps each TPM implementation needs its own hook to do stuff?
> 


 From what I know it's only vTPM with of-tree that needs this.

>>>> +       if (!np)
>>>> +               goto err_free_memblock;
>>>> +
>>>> +       /* logsize must not have changed */
>>>> +       if (of_tpm_get_sml_parameters(np, &unused, &oflogsize) < 0)
>>>> +               goto err_free_memblock;
>>>> +       if (oflogsize != size)
>>>> +               goto err_free_memblock;
>>>> +
>>>> +       /* replace linux,sml-base with new physical address of buffer */
>>>> +       ret = -ENOMEM;
>>>> +       newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
>>>> +       if (!newprop)
>>>> +               goto err_free_memblock;
>>>> +
>>>> +       newprop->name = kstrdup("linux,sml-base", GFP_KERNEL);
>>>> +       if (!newprop->name)
>>>> +               goto err_free_newprop;
>>>> +
>>>> +       newprop->length = sizeof(phyaddr);
>>>> +
>>>> +       newprop->value = kmalloc(sizeof(u64), GFP_KERNEL);
>>>> +       if (!newprop->value)
>>>> +               goto err_free_newprop_struct;
>>>> +
>>>> +       if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
>>>> +           of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
>>>> +               ret = -ENODEV;
>>>> +               goto err_free_newprop_struct;
>>>> +       } else {
>>>> +               *(u64 *)newprop->value = (u64)phyaddr;
>>>> +       }
>>>> +
>>>> +       ret = of_update_property(np, newprop);
>>>
>>> Just FYI for now, there's some work happening on a better API for
>>> writing nodes and properties.
>>
>> Ok.
>>
>>>
>>>> +       if (ret) {
>>>> +               pr_err("Could not update linux,sml-base with new address");
>>>> +               goto err_free_newprop_struct;
>>>> +       }
>>>> +
>>>> +       goto exit;
>>>> +
>>>> +err_free_newprop_struct:
>>>> +       kfree(newprop->name);
>>>> +err_free_newprop:
>>>> +       kfree(newprop);
>>>> +err_free_memblock:
>>>> +       memblock_phys_free((phys_addr_t)phyaddr, size);
>>>> +exit:
>>>> +       tpm_of_remove_kexec_buffer();
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +postcore_initcall(tpm_post_kexec);
>>>
>>> Would be better if this is called explicitly at the right time when
>>> needed rather than using an initcall.
>>
>> The 'when needed' would be the TPM subsystem. However, if I was to make it
>> dependent on the TPM subsystem we would loose the TPM log if we were not to
>> kexec into a kernel with TPM subsystem or the TPM driver wasn't activated. I
>> wanted to be able to preserve the log even if a kexec'ed kernel didn't
>> support or activate the TPM driver and then a subsequent one again has it
>> activated...
> 
> Sounds like a TPM problem the TPM code should deal with. Or a scenario
> that just shouldn't be supported. IDK

It only comes down to from where tpm_post_kexec() is called. The 
postcore_initcall() solves the issue this series is addressing in a more 
general way than if it's called from the TPM subsystem. If this initcall 
is unacceptable then I guess we would have to call if from the TPM 
subsystem - no other choice then.


   Thanks.
     Stefan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
