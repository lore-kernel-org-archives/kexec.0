Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XH92K-0001Z8-B7
 for kexec@lists.infradead.org; Tue, 12 Aug 2014 10:10:36 +0000
Date: Tue, 12 Aug 2014 18:08:50 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 4/7] set vmcoreinfo for kcore
Message-ID: <20140812100850.GD4887@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-5-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9724660F@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9724660F@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/01/14 at 07:12am, Atsushi Kumagai wrote:

> >+#define UNINITIALIZED  ((ulong)(-1))
> >+int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len)
> >+{
> >+	int i;
> >+	ulong kvaddr;
> >+	off_t offset;
> >+	char note[MAX_SIZE_NHDR];
> >+	int size_desc;
> >+	off_t offset_desc;
> >+
......
> >+
> >+	if (offset == UNINITIALIZED){
> >+		ERRMSG("Can't seek the dump memory(%s). %s\n",
> >+		    name_memory, strerror(errno));
> >+		return FALSE;
> >+	}
> >+
> >+        if (lseek(fd_memory, offset, SEEK_SET) != offset){
> >+		ERRMSG("Can't seek the dump memory(%s). %s\n",
> >+		    name_memory, strerror(errno));
> >+		return FALSE;
> >+	}
> 
> These two error messages are the same, they aren't helpful for debugging.
> I think the former should be like "Can't get the offset of VMCOREINFO".

Yeah, great idea, will change.


> >+/* Returns the physical address of start of crash notes buffer for a kernel. */
> >+static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
> >+{
> 
> This function just return the result status, so please use TRUE or FALSE
> as the return value instead of 0 or -1.

Will do.

> 

> >+	if (!(fp = fopen("/sys/kernel/vmcoreinfo", "r")))
> >+		return -1;
> >+
> >+	if (!fgets(line, sizeof(line), fp))
> >+		ERRMSG("Cannot parse %s: %s\n", "/sys/kernel/vmcoreinfo", strerror(errno));
> >+	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
> >+	if (count != 2)
> >+		ERRMSG("Cannot parse %s: %s\n", "/sys/kernel/vmcoreinfo", strerror(errno));
> 
> The messages are the same, too.

Will change.

> 
> 
> Thanks
> Atsushi Kumagai
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
