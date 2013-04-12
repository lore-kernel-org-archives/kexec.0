Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQcaq-0001i5-CO
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 11:56:37 +0000
Message-ID: <5167F670.2040001@citrix.com>
Date: Fri, 12 Apr 2013 12:56:32 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 3/8] kexec: add public interface for improved
 load/unload sub-ops
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-4-git-send-email-david.vrabel@citrix.com>
 <5163E04702000078000CB994@nat28.tlf.novell.com>
In-Reply-To: <5163E04702000078000CB994@nat28.tlf.novell.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Daniel Kiper <daniel.kiper@oracle.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 09/04/13 08:32, Jan Beulich wrote:
>>>> On 08.04.13 at 20:59, David Vrabel <david.vrabel@citrix.com> wrote:
>> @@ -152,6 +152,63 @@ typedef struct xen_kexec_range {
>>      unsigned long start;
>>  } xen_kexec_range_t;
>>  
>> +#if __XEN_INTERFACE_VERSION__ >= 0x00040300
>> +/*
>> + * A contiguous chunk of a kexec image and it's destination machine
>> + * address.
>> + */
>> +typedef struct xen_kexec_segment {
>> +    XEN_GUEST_HANDLE_64(const_void) buf;
>> +    uint64_t buf_size;
>> +    uint64_t dest_maddr;
>> +    uint64_t dest_size;
> 
> So you made uint64_aligned_t available in the previous patch,
> but now you don't use it?

It's not needed here.  Should I use uint64_aligned_t anyway?

It was easier to make both XEN_GUEST_HANDLE_64() and uint64_aligned_t
available than to make only one.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
