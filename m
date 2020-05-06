Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWKYA-00041L-2A
 for kexec@lists.infradead.org; Wed, 06 May 2020 13:57:27 +0000
Received: by mail-wm1-x344.google.com with SMTP id r26so2797293wmh.0
 for <kexec@lists.infradead.org>; Wed, 06 May 2020 06:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200504190227.18269-1-david@redhat.com>
 <20200504190227.18269-2-david@redhat.com>
In-Reply-To: <20200504190227.18269-2-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 6 May 2020 15:57:13 +0200
Message-ID: <CAM9Jb+hni2G69n5djfY7mqFALhk9QxGgyr1dkkGx4VTJLmhGGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/memory_hotplug: Introduce
 add_memory_device_managed()
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
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Linux MM <linux-mm@kvack.org>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>

Looks good to me.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
