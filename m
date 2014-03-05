Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qg0-x22c.google.com ([2607:f8b0:400d:c04::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WL23b-0006bb-3b
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 02:59:43 +0000
Received: by mail-qg0-f44.google.com with SMTP id a108so1292933qge.3
 for <kexec@lists.infradead.org>; Tue, 04 Mar 2014 18:59:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMBSHm_fvPTjdEwgVdyMGPi=3et+JEP-G5TNV986yXWYw35YYw@mail.gmail.com>
References: <CAMBSHm_fvPTjdEwgVdyMGPi=3et+JEP-G5TNV986yXWYw35YYw@mail.gmail.com>
Date: Tue, 4 Mar 2014 18:52:17 -0800
Message-ID: <CAMBSHm89oxceGi=cSwSMLRtaVwQ=oX=BZeBtCg_-trN+1HShkg@mail.gmail.com>
Subject: Re: PATCH: bug in locate_hole()
From: Matthew Fleming <mdf356@gmail.com>
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
To: kexec@lists.infradead.org

On Mon, Mar 3, 2014 at 4:34 PM, Matthew Fleming <mdf356@gmail.com> wrote:
> In upgrading to kexec-tools 2.0.5 I first got the error "Overlapping
> memory segments at 0xbeff000"
>
> Adding some debugging I found locate_hole was returning incorrect
> values.  The below is from the debug I added:
>
> XXXMDF: look for hole size 100000, cur range [52b3000, bffffff] size 6d4cfff
> XXXMDF: look for hole memsz=100000, found beff000
>
> Hmm, if we wanted 0x100000 bytes ending at 0xbffffff, that should be
> 0xbf00000, not 0xbef000.  Continuing to the second invocation:
>
> XXXMDF: look for hole size 1000, cur range [52b3000, befefff] size 6c4bfff
> XXXMDF: look for hole size 1000, cur range [bfff000, bffffff] size fff
> XXXMDF: look for hole memsz=1000, found bffe000
>
> Now we die with overlapping ranges, since the 0x100000 bytes at
> 0xbeff000 overlaps 0x1000 bytes at 0xbffe000.
>
> The attached patch fixes the off-by-one that causes the later overlap.

Fix an off-by-one in locate_hole() that can cause it to return a range
that was previously allocated.

Signed-off-by: Matthew Fleming <mdf356@gmail.com>

Cheers,
matthew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
