Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJE5N-0002Hv-HT
 for kexec@lists.infradead.org; Tue, 20 Dec 2016 06:39:42 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 1/2] eppic: vhost_net_buffers - Adopt to struct sk_buff
 changes
Date: Tue, 20 Dec 2016 06:35:59 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E8D0B1@BPXM01GP.gisp.nec.co.jp>
References: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E8CA8E@BPXM01GP.gisp.nec.co.jp>
 <269b8b17-1067-7b4a-1665-b94bd5ab7e91@linux.vnet.ibm.com>
In-Reply-To: <269b8b17-1067-7b4a-1665-b94bd5ab7e91@linux.vnet.ibm.com>
Content-Language: ja-JP
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
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Monday 19 December 2016 01:04 PM, Atsushi Kumagai wrote:
>> Hello Kamalesh,
>>
>> Thanks for taking care of the scripts.
>>
>> The current scripts are created based on the same kernel version:
>>
>>     ===================================
>>      Eppic scripts README
>>     ==================================
>>
>>     The eppic scripts are based on the fedora 19 kernel.
>>
>> So if you update a part of the scripts, the target kernel version of
>> them will be complex and confusing.
>> I don't think we need to update these scripts since they are just sample,
>> the purpose is to tell users how to write a script.
>>
>
>Thank you for the review. Agree, these scripts are guide on how to write
>eppic
>scripts. On the other hand, if the user tries to run these scripts on
>the latest kernel +
>supported makedumpfile for that release, they would fail. These scripts
>are outdated,
>when run on latest kernel due to data structure changes. I can take up the
>responsibility of maintaining eppic scripts against kernel changes for
>every makedumpfile
>release.

If you will maintain them after this, I have no reason to reject it.
I don't think all of the kernel version should be covered by the samples,
but it's better to keep existing scripts because users don't always use
the latest kernel.
For that reason, I want to clarify the correspondence between script file
and kernel version at least for existing files like:

  vhost_net_buffers_2_6_18_to_2_6_32.c
  vhost_net_buffers_2_6_33_to_3_10.c
  vhost_net_buffers_3_11_to_4_8.c
  ...
  // just sample, not fact

Of course writing the correspondence table into README is OK,
any ideas are welcome. After this clean up, let's follow up
newer kernel versions.


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
