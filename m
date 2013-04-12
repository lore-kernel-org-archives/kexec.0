Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQdaW-0003Hg-MW
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 13:00:21 +0000
Message-Id: <516821AD02000078000CCBE5@nat28.tlf.novell.com>
Date: Fri, 12 Apr 2013 14:01:01 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 3/8] kexec: add public interface for
 improved load/unload sub-ops
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-4-git-send-email-david.vrabel@citrix.com>
 <5163E04702000078000CB994@nat28.tlf.novell.com>
 <5167F670.2040001@citrix.com>
In-Reply-To: <5167F670.2040001@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Daniel Kiper <daniel.kiper@oracle.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

>>> On 12.04.13 at 13:56, David Vrabel <david.vrabel@citrix.com> wrote:
> On 09/04/13 08:32, Jan Beulich wrote:
>>>>> On 08.04.13 at 20:59, David Vrabel <david.vrabel@citrix.com> wrote:
>>> @@ -152,6 +152,63 @@ typedef struct xen_kexec_range {
>>>      unsigned long start;
>>>  } xen_kexec_range_t;
>>>  
>>> +#if __XEN_INTERFACE_VERSION__ >= 0x00040300
>>> +/*
>>> + * A contiguous chunk of a kexec image and it's destination machine
>>> + * address.
>>> + */
>>> +typedef struct xen_kexec_segment {
>>> +    XEN_GUEST_HANDLE_64(const_void) buf;
>>> +    uint64_t buf_size;
>>> +    uint64_t dest_maddr;
>>> +    uint64_t dest_size;
>> 
>> So you made uint64_aligned_t available in the previous patch,
>> but now you don't use it?
> 
> It's not needed here.  Should I use uint64_aligned_t anyway?
> 
> It was easier to make both XEN_GUEST_HANDLE_64() and uint64_aligned_t
> available than to make only one.

Ah, okay. And now that I think about it again, perhaps the less
extensions we need to use, the better. So I guess it's fine to
keep things the way they are in this regard.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
