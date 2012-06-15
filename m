Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SfMpW-0007Jc-A1
 for kexec@lists.infradead.org; Fri, 15 Jun 2012 03:04:12 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7183E3EE0AE
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 12:04:07 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5547C45DE55
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 12:04:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2E2AB45DD78
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 12:04:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1E2C71DB803C
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 12:04:07 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CCA5AE18001
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 12:04:06 +0900 (JST)
Date: Fri, 15 Jun 2012 12:03:46 +0900 (JST)
Message-Id: <20120615.120346.21747125.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 3/5] KVM-INTEL: Add new module vmcsinfo-intel to
 fill VMCSINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4FD9E936.3030001@redhat.com>
References: <4FB35C48.30708@cn.fujitsu.com> <4FB35D60.6050009@cn.fujitsu.com>
 <4FD9E936.3030001@redhat.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: avi@redhat.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, gregkh@linuxfoundation.org, ludwig.nussel@suse.de

From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH v2 3/5] KVM-INTEL: Add new module vmcsinfo-intel to fill VMCSINFO
Date: Thu, 14 Jun 2012 16:37:58 +0300

> On 05/16/2012 10:55 AM, zhangyanfei wrote:
<cut>
>> +
>> +/*
>> + * The format of VMCSINFO is given below:
>> + *   +-------------+--------------------------+
>> + *   | Byte offset | Contents                 |
>> + *   +-------------+--------------------------+
>> + *   | 0           | VMCS revision identifier |
>> + *   +-------------+--------------------------+
>> + *   | 4           | <field><encoded offset>  |
>> + *   +-------------+--------------------------+
>> + *   | 16          | <field><encoded offset>  |
>> + *   +-------------+--------------------------+
>> + *   ......
>> + *
>> + * The first 32 bits of VMCSINFO contains the VMCS revision
>> + * identifier.
>> + * The remainder of VMCSINFO is used for <field><encoded offset>
>> + * sets. Each set takes 12 bytes: field occupys 4 bytes
>> + * and its corresponding encoded offset occupys 8 bytes.
>> + *
>> + * Encoded offsets are raw values read by vmcs_read{16, 64, 32, l},
>> + * and they are all unsigned extended to 8 bytes for each
>> + * <field><encoded offset> set has the same size.
>> + * We do not decode offsets here. The decoding work is delayed
>> + * in userspace tools.
> 
> It's better to do the decoding here, or no one will know how to do it.
> Also have an nfields field.

We did so because actual internal format is unkown; it could possibly
be encrypted, although unlikely. We thought processing such unkown
data should have been done in userland debugging tools. But decoding
them here is no problem; the decode is of simple shift operations and
has no risk affecting system status, there's only possibility to
display broken values, which is same as the case displaying the
encrypted values for users.

FYI, the assumptions behind the reverse enginerring method are:

- For each field, the corresponding offset is unique; IOW, arbitrary
  two offsets for the corresponding two fields are different each
  other.
- Field size remains 8 bytes, 16 bytes, 32 bytes even on vmcs region.
- Each field is 8 byte alighed on vmcs region.
- Some fields may be big endition on vmcs region.
  - We found this fact under development. We give up if the data is
    modified more drastically.
- offset < vmcs region size

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
