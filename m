Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USPLN-0000wk-DS
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 10:12:02 +0000
Message-ID: <516E756B.5060404@citrix.com>
Date: Wed, 17 Apr 2013 11:11:55 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
 <1366132390-5269-6-git-send-email-david.vrabel@citrix.com>
 <516E7F9802000078000CDE3C@nat28.tlf.novell.com>
In-Reply-To: <516E7F9802000078000CDE3C@nat28.tlf.novell.com>
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
To: Jan Beulich <JBeulich@suse.com>
Cc: "Keir (Xen.org)" <keir@xen.org>, Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 17/04/13 09:55, Jan Beulich wrote:
>>>> On 16.04.13 at 19:13, David Vrabel <david.vrabel@citrix.com> wrote:
>> -static int kexec_exec(XEN_GUEST_HANDLE_PARAM(void) uarg)
>> +static int kexec_load(XEN_GUEST_HANDLE_PARAM(void) uarg)
>>  {
>> -    xen_kexec_exec_t exec;
>> -    xen_kexec_image_t *image;
>> -    int base, bit, pos, ret = -EINVAL;
>> +    xen_kexec_load_t load;
>> +    xen_kexec_segment_t *segments;
>> +    struct kexec_image *kimage = NULL;
>> +    int ret;
>>  
>> -    if ( unlikely(copy_from_guest(&exec, uarg, 1)) )
>> +    if ( copy_from_guest(&load, uarg, 1) )
>>          return -EFAULT;
>>  
>> -    if ( kexec_load_get_bits(exec.type, &base, &bit) )
>> +    if ( load.nr_segments >= KEXEC_SEGMENT_MAX )
>>          return -EINVAL;
> 
> Especially since you named the padding field _rsvd, you ought
> to verify it to be zero somewhere here. Or if you're really sure
> that nobody will ever want to make use of the field, name it
> _pad instead.

8 bits isn't likely to be useful and the interface can always be
extended by adding a new sub-ob.  I'll rename it to _pad.

Do you want to put your acked-by on this patch (with this change) or on
any of the other patches?

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
