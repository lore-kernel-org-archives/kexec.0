Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from prv1-mh.provo.novell.com ([137.65.248.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRBz-0002yr-Pd
 for kexec@lists.infradead.org; Tue, 29 Jan 2019 11:04:37 +0000
Message-Id: <5C50333F020000780014B85A@prv1-mh.provo.novell.com>
Date: Tue, 29 Jan 2019 04:04:31 -0700
From: "Jan Beulich" <jbeulich@suse.com>
Subject: Re: [Xen-devel] [RFC v1 0/8] Prototype for kexec signature
 verification within Xen
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: eric.devolder@oracle.com
Cc: boris.ostrovsky@oracle.com, kexec@lists.infradead.org, daniel.kiper@oracle.com, xen-devel@lists.xen.org

>>> Eric DeVolder <eric.devolder@oracle.com> 01/14/19 8:48 PM >>>
>On April 20, 2018, I posted to xen-devel an RFC inquiring about
>support for signature verification of kexec within Xen:
>
>https://lists.xenproject.org/archives/html/xen-devel/2018-04/msg01655.html
>
>Since then, I've worked towards a solution. For the purposes of
>understanding signature verification, I built a standalone utility to
>parse the xen.mb.efi PECOFF file, hash it contents, and extract its
>digitial certificate and perform the Authenticode signature
>verification. Once this was all working, I integrated the files into
>Xen.

Perhaps I'm just lacking some context, but neither the mail referenced
above nor my looking at the Linux code reveal any connection to PE-COFF.
How's that file format becoming of interest here all of the sudden?

Jan



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
