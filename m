Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USriQ-00038h-9i
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 16:29:43 +0000
Message-ID: <51701F6D.6050608@citrix.com>
Date: Thu, 18 Apr 2013 17:29:33 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
 <1366132390-5269-6-git-send-email-david.vrabel@citrix.com>
 <20130417125106.GB906@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130417125106.GB906@debian70-amd64.local.net-space.pl>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Keir (Xen.org)" <keir@xen.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 17/04/13 13:51, Daniel Kiper wrote:
> On Tue, Apr 16, 2013 at 06:13:07PM +0100, David Vrabel wrote:
>> 
>>      }
>>
>> +    code_page = __map_domain_page(image->control_code_page);
>> +    memcpy(code_page, kexec_reloc, PAGE_SIZE);
> 
> memcpy(code_page, kexec_reloc, kexec_reloc_size);

kexec_reloc_size is absolute symbol and doing this give linker errors.
FWIW, Linux also uses a #define'd value for its similar memcpy.

I have added a link time check that kexec_reloc_size <= PAGE_SIZE.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
