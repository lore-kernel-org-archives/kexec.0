Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from prv1-mh.provo.novell.com ([137.65.248.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQzh-0005Bq-VZ
 for kexec@lists.infradead.org; Tue, 29 Jan 2019 10:51:55 +0000
Message-Id: <5C503045020000780014B84C@prv1-mh.provo.novell.com>
Date: Tue, 29 Jan 2019 03:51:49 -0700
From: "Jan Beulich" <jbeulich@suse.com>
Subject: Re: [Xen-devel] [RFC v1 1/8] kexec: add kexec_file_load to libxenctrl
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
 <1547495285-28907-2-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-2-git-send-email-eric.devolder@oracle.com>
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

>>> Eric DeVolder <eric.devolder@oracle.com> 01/14/19 8:49 PM >>>
>@@ -213,8 +214,9 @@ typedef struct xen_kexec_load {
>uint64_t _pad;
>} segments;
>uint64_t entry_maddr; /* image entry point machine address. */
>-} xen_kexec_load_t;
>+} xen_kexec_load_t, xen_kexec_file_load_t;
>DEFINE_XEN_GUEST_HANDLE(xen_kexec_load_t);
>+DEFINE_XEN_GUEST_HANDLE(xen_kexec_file_load_t);
 
I don't see the need for this extra typedef and handle.

Jan



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
