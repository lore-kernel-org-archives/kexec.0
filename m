Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 27 Nov 2018 15:15:25 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181127071525.GF1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181126012824.GB1824@MiWiFi-R3L-srv>
 <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
 <20181127064816.GE1824@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181127064816.GE1824@MiWiFi-R3L-srv>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: k-hagio@ab.jp.nec.com, james.morse@arm.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, osandov@fb.com, bp@alien8.de, anderson@redhat.com, tglx@linutronix.de, bhupesh.linux@gmail.com, mingo@kernel.org, linux-arm-kernel@lists.infradead.org

On 11/27/18 at 02:48pm, Baoquan He wrote:
 
> #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
> 	VMCOREINFO_SYMBOL(node_data);
	^^^ 

> #endif

Wrong copy
#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
	VMCOREINFO_NUMBER(page_offset_base);

#endif


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
