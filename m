Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPbCM-00077R-FA
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 16:15:07 +0000
Message-ID: <51643E86.7060707@citrix.com>
Date: Tue, 9 Apr 2013 17:15:02 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 1/8] x86: give FIX_EFI_MPF its own fixmap entry
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-2-git-send-email-david.vrabel@citrix.com>
 <5163DEE802000078000CB98B@nat28.tlf.novell.com>
In-Reply-To: <5163DEE802000078000CB98B@nat28.tlf.novell.com>
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

On 09/04/13 08:27, Jan Beulich wrote:
>>>> On 08.04.13 at 20:59, David Vrabel <david.vrabel@citrix.com> wrote:
>> FIX_EFI_MPF was the same as FIX_KEXEC_BASE_0 which is going away.  So
>> add its own entry.
> 
> To be honest, no matter how small the wastage, I'd prefer reusing
> another entry over creating a new one. FIX_TBOOT_MAP_ADDRESS
> seems like a reasonable fit (which we also don't have to expect to
> go away, unless tboot support would get ripped out altogether).
> This is not the least because sane UEFI systems aren't expected to
> have MPS tables anyway (i.e. the entry, if separate, would likely
> _never_ be used in reality), it's just that the specification allows for
> it.

This patch added one entry and patch 5 removes 68 entries so this series
is a big gain as is.  It doesn't seem productive to further improve this
at this time.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
