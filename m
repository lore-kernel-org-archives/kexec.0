Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1US7K3-0008CL-9I
 for kexec@lists.infradead.org; Tue, 16 Apr 2013 14:57:27 +0000
Message-ID: <516D66C8.2070900@citrix.com>
Date: Tue, 16 Apr 2013 15:57:12 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-6-git-send-email-david.vrabel@citrix.com>
 <20130409210241.GB31533@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130409210241.GB31533@debian70-amd64.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ian Campbell <Ian.Campbell@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 09/04/13 22:02, Daniel Kiper wrote:
> On Mon, Apr 08, 2013 at 07:59:50PM +0100, David Vrabel wrote:
>> 
>> -static int kexec_load_unload_compat(unsigned long op,
>> -                                    XEN_GUEST_HANDLE_PARAM(void) uarg)
>> +static int kexec_load_v1_compat(XEN_GUEST_HANDLE_PARAM(void) uarg)
>>  {
>>  #ifdef CONFIG_COMPAT
>>      compat_kexec_load_v1_t compat_load;
>> @@ -808,49 +1011,113 @@ static int kexec_load_unload_compat(unsigned long op,
>>      load.type = compat_load.type;
>>      XLAT_kexec_image(&load.image, &compat_load.image);
>>
>> -    return kexec_load_unload_internal(op, &load);
>> -#else /* CONFIG_COMPAT */
>> +    return kexec_do_load_v1(&load, 1);
>> +#else
> 
> Why did you removed comment?

It's unhelpful clutter when the #if/#else/#endif are close together.

>>      return 0;
> 
> Why not -ENOSYS?

It's unreachable code so it doesn't matter.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
